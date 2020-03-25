function Invoke-IcingaApiChecksRESTCall()
{
    param (
        [Hashtable]$Request    = @{},
        [Hashtable]$Connection = @{},
        $IcingaGlobals
    );

    # Initialise some global variables we use to actually store check result data from
    # plugins properly. This is doable from each thread instance as this part isnt
    # shared between daemons
    New-IcingaCheckSchedulerEnvironment;

    [Hashtable]$ContentResponse = @{};

    # Short our call
    $CheckerAliases = $IcingaGlobals.BackgroundDaemon.IcingaPowerShellRestApi.CommandAliases.checker;
    $CheckConfig    = $Request.Body;

    # Check if there are an inventory aliases configured
    # This should be maintained by the developer and not occur
    # anyway
    if ($null -eq $CheckerAliases) {
        Send-IcingaTCPClientMessage -Message (
            New-IcingaTCPClientRESTMessage `
                -HTTPResponse ($IcingaHTTPEnums.HTTPResponseType.'Internal Server Error') `
                -ContentBody 'Internal Server Error. For this API endpoint no configured command aliases were found.'
        ) -Stream $Connection.Stream;

        return;
    }

    # Our namespace to include inventory packages is 'include' over the api
    # Everything else will be dropped for the moment
    if ($Request.RequestArguments.ContainsKey('command')) {
        foreach ($element in $CheckerAliases.Keys) {
            if ($Request.RequestArguments.command -Contains $element) {

                $command = $CheckerAliases[$element];

                Write-IcingaDebugMessage -Message ('Executing API check for command: ' + $command);

                if ([string]::IsNullOrEmpty($CheckConfig) -eq $FALSE) {
                    # Convert our JSON config for checks to a PSCustomObject
                    $PSArguments = ConvertFrom-Json -InputObject $CheckConfig;

                    # For executing the checks, we will require the data as
                    # hashtable, so declare it here
                    [hashtable]$Arguments = @{};

                    # Now convert our custom object by Key<->Value to
                    # a valid hashtable, allowing us to parse arguments
                    # to our check command
                    $PSArguments.PSObject.Properties | ForEach-Object { 
                        Add-IcingaHashtableItem `
                            -Hashtable $Arguments `
                            -Key $_.Name `
                            -Value $_.Value | Out-Null;
                    };

                    $ExitCode = Invoke-Command -ScriptBlock { return &$command @Arguments };
                } else {
                    $ExitCode = Invoke-Command -ScriptBlock { return &$command };
                }

                # Once the check is executed, the plugin output and the performance data are stored
                # within a special cache map we can use for accessing
                $CheckResult = Get-IcingaCheckSchedulerPluginOutput;
                $PerfData    = Get-IcingaCheckSchedulerPerfData;

                Add-IcingaHashtableItem `
                    -Hashtable $ContentResponse `
                    -Key $command `
                    -Value @{
                        'exitcode'    = $ExitCode;
                        'checkresult' = $CheckResult;
                        'perfdata'    = $PerfData;
                    } | Out-Null;
            }
        }
    }

    if ($ContentResponse.Count -eq 0) {
        $ContentResponse.Add(
            'message',
            'Welcome to the Icinga for Windows API checker. To execute checks, please use the command parameter. For providing arguments, you will habe to submit a post woth JSON encoded arguments. Example: /v1/checker?command=cpu'
        );
    }

    # Send the response to the client
    Send-IcingaTCPClientMessage -Message (
        New-IcingaTCPClientRESTMessage `
            -HTTPResponse ($IcingaHTTPEnums.HTTPResponseType.Ok) `
            -ContentBody $ContentResponse
    ) -Stream $Connection.Stream;
}
