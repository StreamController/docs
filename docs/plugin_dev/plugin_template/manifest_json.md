The [manifest.json](manifest_json.md) file contains information about the plugin.


Per default the file looks like this:
```json title="manifest.json"
{
    "version": "",
    "thumbnail": "",
    "id": "",
    "name": ""
}
```

As you can see there are four keys you can set.

|Name|Description|
|---|---|
|version|The version of your plugin. This has currently no effect at all.|
|thumbnail|The path to the thumbnail you want to show in the store. This is really important.|
|id|The unique id of your plugin in [reverse domain name notation](https://en.wikipedia.org/wiki/Reverse_domain_name_notation). Because Python has problems if the name contains dots, you must replace them with underscores.|
|name|The name of your plugin. This will only be shown in the store.|