All plugins must have a `attribution.json` file in the root directory. It contains information for the store, such as the license and copyright.

```json
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
The `generic` key contains information about the plugin. If you want to add attribution to images, fonts, etc. you can add them via their relative path, for example:

```json
{
    "assets/icon.png": {
        "copyright": "",
        "original-url": "",
        "license": "",
        "license-url": "",
        "description": ""
    }
}
```

!!! info
    At the moment not all given attribution files are shown to the user.  
    This will change in future versions

## Attributes
|Name|Description|
|---|---|
|`copyright`|The copyright of the plugin.|
|`original-url`|The original url of the plugin.|
|`license`|The license of the plugin.|
|`license-url`|The license url of the plugin.|
|`description`|The description of the license. This is useful if you want to list made modifications|