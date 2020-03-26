Introduction
===

This PowerShell module will provide an endpoint for the [Icinga PowerShell REST-Api](https://icinga.com/docs/windows/latest/restapi) module. By intalling this module, you will be able to execute check plugins over the REST-Api without requiring to use the Icinga 2 Agent for checks.

Please note that this is not intended to be a replacement for the Icinga 2 Agent itself, but more an extension to easier develop and debug modules remotely and to verify your environment is working properly.

In addition this module is helpful for integration into other tools to fetch certain low-level informations.

The following requirements have to be fullfilled:

* Windows 7 / Windows 2008 R2 or later
* PowerShell Version 4.x or higher
* [Icinga PowerShell Framework](https://icinga.com/docs/windows) installed
* [Icinga PowerShell Plugins](https://icinga.com/docs/windows/latest/plugins) installed
* [Icinga PowerShell REST-Api](https://icinga.com/docs/windows/latest/restapi) installed

If you are ready to get started, take a look at the [installation guide](02-Installation.md).
