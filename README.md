# Deprecation Notice

This repository is deprecated and no longer required, as starting with Icinga for Windows v1.7.0 the Api-Checks component is a core module of the [icinga-powershell-framework](https://github.com/Icinga/icinga-powershell-framework) and natively included.

If you have Icinga for Windows v1.7.0 or later installed, you can uninstall the component by using

```powershell
Uninstall-IcingaComponent -Name 'apichecks'
```

# Icinga PowerShell API-Checks

This repository provides an API endpoint for the [Icinga PowerShell REST-Api](https://github.com/Icinga/icinga-powershell-restapi) to execute checks provided by the [Icinga PowerShell Plugins](https://github.com/Icinga/icinga-powershell-plugins) or from custom development based on the [Icinga PowerShell Framework](https://github.com/Icinga/icinga-powershell-framework).

Before you continue, please take a look on the [installation guide](doc/02-Installation.md)

## Documentation

Please take a look on the following content for installation and documentation:

* [Introduction](doc/01-Introduction.md)
* [Installation Guide](doc/02-Installation.md)
* [API documentation](doc/03-API-Documentation.md)
* [Changelog](doc/31-Changelog.md)

## Contributing

The Icinga for Windows solution is an Open Source project and lives from your contributions. No matter whether these are feature requests, issues, translations, documentation or code.

* Please check whether a related issue already exists on our [Issue Tracker](https://github.com/Icinga/icinga-powershell-apichecks/issues)
* Send a [Pull Request](https://github.com/Icinga/icinga-powershell-apichecks/pulls)
* The master branch shall never be corrupt!
