<#
.SYNOPSIS
   Registers an endpoint called 'checker' in our REST-Api
.DESCRIPTION
   This module will provide an endpoint for the Icinga for Windows REST-Api
   https://github.com/Icinga/icinga-powershell-restapi

   The endpoint itself is called 'checker' and will map available Cmdlets for
   check plugins
.FUNCTIONALITY
   This module will depend on the Icinga Plugins as well as the Framework and
   the REST-Api. It will provide a wrapper to execute Icinga Plugins over the
   REST-Api and fetch the plugin output
.OUTPUTS
   $NULL
.LINK
   https://github.com/Icinga/icinga-powershell-apichecks
.NOTES
#>
function Register-IcingaRESTAPIEndpointAPIChecks()
{
    return @{
        'Alias'   = 'checker';
        'Command' = 'Invoke-IcingaApiChecksRESTCall';
    };
}

<#
.SYNOPSIS
   Registers our command aliases for mapping the 'command' argument
   from our REST-Call securely to our PowerShell Cmdlets
.DESCRIPTION
   This module will provide an endpoint for the Icinga for Windows REST-Api
   https://github.com/Icinga/icinga-powershell-restapi

   By using the references, we can register endpoints and aliases to fetch
   informations
.EXAMPLE
   https://example.com/v1/checker?command=cpu
.FUNCTIONALITY
   This module will depend on the Icinga Plugins as well as the Framework and
   the REST-Api. It will provide a wrapper to execute Icinga Plugins over the
   REST-Api and fetch the plugin output
.OUTPUTS
   $NULL
.LINK
   https://github.com/Icinga/icinga-powershell-apichecks
.NOTES
#>
function Register-IcingaRESTApiCommandAliasesApiChecks()
{
    return @{
        'checker' = @{
            'bios'        = 'Invoke-IcingaCheckBiosSerial';
            'cpu'         = 'Invoke-IcingaCheckCPU';
            'checksum'    = 'Invoke-IcingaCheckSum';
            'dir'         = 'Invoke-IcingaCheckDirectory';
            'eventlog'    = 'Invoke-IcingaCheckEventlog';
            'firewall'    = 'Invoke-IcingaCheckFirewall';
            'memory'      = 'Invoke-IcingaCheckMemory';
            'nla'         = 'Invoke-IcingaCheckNLA';
            'perfcounter' = 'Invoke-IcingaCheckPerfcounter';
            'process'     = 'Invoke-IcingaCheckProcessCount';
            'service'     = 'Invoke-IcingaCheckService';
            'updates'     = 'Invoke-IcingaCheckUpdates';
            'uptime'      = 'Invoke-IcingaCheckUptime';
            'partition'   = 'Invoke-IcingaCheckUsedPartitionSpace';
            'user'        = 'Invoke-IcingaCheckUsers';
            'cert'        = 'Invoke-IcingaCheckCertificate';
        }
    }
}
