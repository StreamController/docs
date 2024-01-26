The [attribution.json](attribution_json.md) file is used to provide attribution to third party assets used in your plugin, e.g. fonts, images, etc.

Per default the file looks like this:
```json title="attribution.json"
{
    "generic": {
        "copyright": "",
        "original-url": "",
        "license": "",
        "license-url": "",
        "description": ""
    }
}
```

You can add files you want to give credit to by adding their relative path as a new key.
This might look like this:
```json title="attribution.json"
{
    "generic": {
        "copyright": "",
        "original-url": "",
        "license": "",
        "license-url": "",
        "description": ""
    },
    "path/to/file": {
        "copyright": "",
        "original-url": "",
        "license": "",
        "license-url": "",
        "description": ""
    }
}
```

The shown `generic` controls the default and therefore sets the values for all not otherwise specified files.

### Description of the keys
|Key|Description|
|---|---|
|copyright|The copyright holder of the file.|
|original-url|The original url of the file.|
|license|The license of the file, e.g. `MIT`|
|license-url|The url of the license, e.g. `https://opensource.org/licenses/MIT`|
|description|Describe any changes or additions made to the file.|