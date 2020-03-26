# API Documentation

This module is providing a REST endpoint for the [Icinga PowerShell REST-Api](https://icinga.com/docs/windows/latest/restapi).

Once the module is [installed](02-Installation.md) you can access it over the API under its namespace

```url
/v1/checker
```

The module will only support to query one check command per connection.

## Fetch list of available checks

To receive a list of all available checks over the API you can simply run

```url
/v1/checker?list
```

```json
{
    "Commands": {
        "bios": "Invoke-IcingaCheckBiosSerial",
        "cpu": "Invoke-IcingaCheckCPU",
        "checksum": "Invoke-IcingaCheckSum",
        "dir": "Invoke-IcingaCheckDirectory",
        "eventlog": "Invoke-IcingaCheckEventlog",
        "firewall": "Invoke-IcingaCheckFirewall",
        "memory": "Invoke-IcingaCheckMemory",
        "nla": "Invoke-IcingaCheckNLA",
        "perfcounter": "Invoke-IcingaCheckPerfcounter",
        "process": "Invoke-IcingaCheckProcessCount",
        "service": "Invoke-IcingaCheckServices",
        "updates": "Invoke-IcingaCheckUpdates",
        "uptime": "Invoke-IcingaCheckUptime",
        "partition": "Invoke-IcingaCheckUsedPartitionSpace",
        "user": "Invoke-IcingaCheckUsers",
        "cert": "Invoke-IcingaCheckCertificate"
    }
}
```

For acually executing a check you will have to use the alias instead of the real PowerShell Cmdlet.

## Execute check by GET

The simplest way of executing a check is to use the GET method by directly using the browser for example. Simply use the `command` argument and specify the alias for the plugin to execute

```url
/v1/checker?command=cpu
```

```json
{
    "Invoke-IcingaCheckCPU": {
        "exitcode": 0,
        "checkresult": "[OK] Check package \"CPU Load\"",
        "perfdata": [
            "'core_0'=11.44%;;;0;100 ",
            "'core_1'=16.71%;;;0;100 ",
            "'core_2'=2.33%;;;0;100 ",
            "'core_3'=6.7%;;;0;100 ",
            "'core_total'=7.53%;;;0;100 "
        ]
    }
}
```

## Execute check by POST

You can also send a request as `POST` with a JSON body attached to include arguments to your check. In our example we will use ``curl` for this

```bash
 curl -X POST "/v1/checker?command=cpu" --data "{ '-Core': 0 }"
```

```json
{
    "Invoke-IcingaCheckCPU": {
        "exitcode":0,
        "checkresult": "[OK] Check package \"CPU Load\"",
        "perfdata": [
            "'core_0'=11.77%;;;0;100 "
        ]
    }
}
```
