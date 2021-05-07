function Invoke-IcingaApiChecksRESTCall()
{
    param (
        [Hashtable]$Request    = @{},
        [Hashtable]$Connection = @{},
        $IcingaGlobals,
        [string]$ApiVersion    = $null
    );

    # Initialise some global variables we use to actually store check result data from
    # plugins properly. This is doable from each thread instance as this part isn't
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
        $CheckerAliases = @{ };
    }

    if ((Get-IcingaRESTHeaderValue -Request $Request -Header 'Content-Type') -ne 'application/json' -And $Request.Method -eq 'POST') {
        Send-IcingaTCPClientMessage -Message (
            New-IcingaTCPClientRESTMessage `
                -HTTPResponse ($IcingaHTTPEnums.HTTPResponseType.'Bad Request') `
                -ContentBody 'This API endpoint does only accept "application/json" as content type over POST.'
        ) -Stream $Connection.Stream;

        return;
    }

    # Our namespace to include inventory packages is 'include' over the api
    # Everything else will be dropped for the moment
    if ($Request.RequestArguments.ContainsKey('list')) {

        Add-IcingaHashtableItem `
            -Hashtable $ContentResponse `
            -Key 'Commands' `
            -Value $CheckerAliases | Out-Null;

    } elseif ($Request.RequestArguments.ContainsKey('command')) {
        [string]$ExecuteCommand = $null;

        foreach ($element in $CheckerAliases.Keys) {
            if ($Request.RequestArguments.command -Contains $element) {
                $ExecuteCommand = $CheckerAliases[$element];
                # We only support to execute one check per call
                # No need to loop through everything
                break;
            }
        }

        if ([string]::IsNullOrEmpty($ExecuteCommand)) {
            [string]$ExecuteCommand = $Request.RequestArguments.command;
        }

        if ((Test-IcingaFrameworkApiCommand -Command $ExecuteCommand -Endpoint 'apichecks') -eq $FALSE) {
            Send-IcingaTCPClientMessage -Message (
                New-IcingaTCPClientRESTMessage `
                    -HTTPResponse ($IcingaHTTPEnums.HTTPResponseType.'Forbidden') `
                    -ContentBody ([string]::Format('The command "{0}" you are trying to execute over this REST-Api endpoint "apichecks" is not whitelisted for remote execution.', $ExecuteCommand))
            ) -Stream $Connection.Stream;

            return;
        }

        Write-IcingaDebugMessage -Message ('Executing API check for command: ' + $ExecuteCommand);

        if ([string]::IsNullOrEmpty($CheckConfig) -eq $FALSE -And $Request.Method -eq 'POST') {
            # Convert our JSON config for checks to a PSCustomObject
            $PSArguments = ConvertFrom-Json -InputObject $CheckConfig;

            # Now convert our custom object by Key<->Value to
            # a valid argument list, allowing us to bind arguments
            # to our check command
            [array]$Arguments = @($ExecuteCommand);
            $PSArguments.PSObject.Properties | ForEach-Object { 
                 $Arguments += ,('-' + $_.Name);
                 if (-not ([string]::IsNullOrEmpty($_.Value))) { $Arguments += ,$_.Value };
            };

            $CmdScriptBlock = [scriptblock]::Create($Arguments -join " ");
            $ExitCode = Invoke-Command -ScriptBlock $CmdScriptBlock;
        } elseif ($Request.Method -eq 'GET') {
            $ExitCode = Invoke-Command -ScriptBlock { return &$ExecuteCommand };
        } else {
            Send-IcingaTCPClientMessage -Message (
                New-IcingaTCPClientRESTMessage `
                    -HTTPResponse ($IcingaHTTPEnums.HTTPResponseType.Ok) `
                    -ContentBody @{ 'message' = 'This API endpoint does only accept GET and POST methods for requests.' }
            ) -Stream $Connection.Stream;

            return;
        }

        # Once the check is executed, the plugin output and the performance data are stored
        # within a special cache map we can use for accessing
        $CheckResult = Get-IcingaCheckSchedulerPluginOutput;
        $PerfData    = Get-IcingaCheckSchedulerPerfData;

        # Free our memory again
        Clear-IcingaCheckSchedulerEnvironment;

        Write-IcingaDebugMessage -Message 'Check Executed. Result below' -Objects $ExecuteCommand, $CheckResult, $PerfData, $ExitCode;

        Add-IcingaHashtableItem `
            -Hashtable $ContentResponse `
            -Key $ExecuteCommand `
            -Value @{
                'exitcode'    = $ExitCode;
                'checkresult' = $CheckResult;
                'perfdata'    = $PerfData;
            } | Out-Null;
    }

    if ($ContentResponse.Count -eq 0) {
        $ContentResponse.Add(
            'message',
            'Welcome to the Icinga for Windows API checker. To execute checks, please use the command parameter. For providing arguments, you will have to submit a post with JSON encoded arguments. Example: /v1/checker?command=Invoke-IcingaCheckCPU'
        );
    }

    # Send the response to the client
    Send-IcingaTCPClientMessage -Message (
        New-IcingaTCPClientRESTMessage `
            -HTTPResponse ($IcingaHTTPEnums.HTTPResponseType.Ok) `
            -ContentBody $ContentResponse
    ) -Stream $Connection.Stream;
}
