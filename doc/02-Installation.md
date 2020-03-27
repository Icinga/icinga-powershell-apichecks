# Installation

Like any other PowerShell module, the installation itself is very simple and straight forward. As of before, there are many ways to deploy a PowerShell module on a Windows host.

Regardless of the method: In order to make this module work properly, you will have to install it into the same folder as your [Icinga PowerShell Framework](https://icinga.com/docs/windows) module is installed to.

If you installed the Framework into

```text
C:\Program Files\WindowsPowerShell\Modules\
```

you will have to install this module there as well.

## General Note on Installation/Updates

You should always stick to one way of installing/updating any modules for the Icinga for Windows solution. It is **not** supported and **not** recommended to mix installation ways by using `PowerShell Gallery` initially and switch to the `Framework Component Installer` for example later on.

There might be various side effects by doing so.

### PowerShell Gallery

One of the simplier ways is to use PowerShell Gallery for the installation. For this we simply run the command

```powershell
Install-Module 'icinga-powershell-apichecks';
```

### Icinga Framework Component Installer

If PowerShell Gallery is no option for you because it is not available or you prefer the installation from GitHub releases directly, you can use the component installer of the Icinga PowerShell Framework

Install latest stable:

```powershell
Use-Icinga;
Install-IcingaFrameworkComponent -Name apichecks -Stable;
```

Install latest snapshot

```powershell
Use-Icinga;
Install-IcingaFrameworkComponent -Name apichecks -Snapshot;
```

Custom repository source

```powershell
Use-Icinga;
Install-IcingaFrameworkComponent -Name apichecks -Url 'url to your .zip file';
```

### Manual Installation

For manual installation either download the [latest release .zip](https://github.com/Icinga/icinga-powershell-apichecks/releases) or the [latest master .zip](https://github.com/Icinga/icinga-powershell-apichecks) and extract the content into the correct PowerShell modules folder.

Please ensure that the folder name of the module is matching the `.psm1` file name inside the folder. Once this is done, we might require to unblock the file content to be able to load and execute the module

```powershell
Get-Content -Path 'C:\Program Files\WindowsPowerShell\Modules\icinga-powershell-apichecks' -Recurse | Unblock-File;
```

Now we can start a new PowerShell instance and the module should be ready to go. Otherwise we have to import it manually by using

```powershell
Import-Module 'icinga-powershell-apichecks';
```

## Restart the PowerShell Service

Once installed, we are ready to go and can simply restart our Icinga PowerShell daemon.

```powershell
Restart-Service icingapowershell;
```

Afterwards our API endpoint is available and ready.

## API documentation

As we are now ready and our service is restarted, we can start [using the API](03-API-Documentation.md)
