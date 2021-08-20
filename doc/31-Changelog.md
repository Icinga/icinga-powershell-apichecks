# Icinga PowerShell API-Checks CHANGELOG

**The latest release announcements are available on [https://icinga.com/blog/](https://icinga.com/blog/).**

Please read the [upgrading](30-Upgrading-API-Checks.md) documentation before upgrading to a new release.

Released closed milestones can be found on [GitHub](https://github.com/Icinga/icinga-powershell-apichecks/milestones?state=closed).

## 1.2.0 (2021-09-07)

[Issue and PRs](https://github.com/Icinga/icinga-powershell-apichecks/milestone/3?closed=1)

### Bugfixes

* [#5](https://github.com/Icinga/icinga-powershell-apichecks/issues/5) Fixes performance data for executed checks, which did not return an empty array if no data was available or perf data were disabled

## 1.1.1 (2021-07-07)

[Issue and PRs](https://github.com/Icinga/icinga-powershell-apichecks/milestone/4?closed=1)

### Bugfixes

* [#7](https://github.com/Icinga/icinga-powershell-apichecks/pull/7) The Cmdlet being used to test if certain commands can be executed or not, was wrong and has been replaced, which will now cause an exception for the REST-Api daemon.

## 1.1.0 (2021-03-02)

[Issue and PRs](https://github.com/Icinga/icinga-powershell-apichecks/milestone/2?closed=1)

### Breaking Changes

For the new version you will require to whitelist commands to be executed over this module. Please have a look on the [upgrading](30-Upgrading-API-Checks.md) for more details.

### Enhancements

* [#2](https://github.com/Icinga/icinga-powershell-apichecks/pull/2) Removes the enforcing feature to provide alias mapping for Cmdlets (like `Invoke-IcingaCheckCPU` => `cpu`) and replaced the entire handling with proper white-/blacklisting entries for each API endpoint.

## 1.0.1 (2020-06-16)

### Bugfixes

* [#1](https://github.com/Icinga/icinga-powershell-apichecks/issues/1) Service check returning an empty result

## 1.0.0 (2020-06-02)

### Notes

Initial release
