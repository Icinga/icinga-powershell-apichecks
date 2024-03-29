@{
    ModuleVersion = '1.3.0'
    GUID = 'a712759a-1b7c-453d-9490-5b4cc8b2e37a'
    ModuleToProcess = 'icinga-powershell-apichecks.psm1'
    Author = 'Lord Hepipud, Crited'
    CompanyName = 'Icinga GmbH'
    Copyright = '(c) 2021 Icinga GmbH | GPLv2'
    Description = 'A module to extend the REST-Api of the Icinga PowerShell Framework for executing check plugins'
    PowerShellVersion = '4.0'
    RequiredModules = @( @{ModuleName = 'icinga-powershell-framework'; ModuleVersion = '1.6.0' }, @{ModuleName = 'icinga-powershell-restapi'; ModuleVersion = '1.2.0' }, 'icinga-powershell-plugins' )
    NestedModules = @(
        '.\lib\Invoke-IcingaApiChecksRESTCall.psm1'
    )
    FunctionsToExport = @('*')
    CmdletsToExport = @('*')
    VariablesToExport = '*'
    AliasesToExport = @()
    PrivateData = @{
        PSData = @{
            Tags = @( 'icinga','icinga2','apichecks','icingachecks','windowsrest','icingawindows')
            LicenseUri = 'https://github.com/Icinga/icinga-powershell-apichecks/blob/master/LICENSE'
            ProjectUri = 'https://github.com/Icinga/icinga-powershell-apichecks'
            ReleaseNotes = 'https://github.com/Icinga/icinga-powershell-apichecks/releases'
        };
        Version  = 'v1.3.0';
        Name     = 'API Checks';
        Type     = 'apiendpoint';
        Endpoint = 'checker';
    }
    HelpInfoURI = 'https://github.com/Icinga/icinga-powershell-apichecks'
}
