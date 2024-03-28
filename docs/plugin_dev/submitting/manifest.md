All plugins must have a `manifest.json` file in the root directory. It contains information for the store, such as the name, version and thumbnail of your plugin.

The `manifest.json` has the following structure:
```json
{
    "version": "",
    "thumbnail": "",
    "id": "",
    "name": "",
    "description": "",
}
```

## Attributes
|Name|Description|
|---|---|
|`version`|The version of the plugin.|
|`thumbnail`|The relative path to the thumbnail. Recommended is: `store/Thumbnail.png`|
|`id`|The identifier of the plugin.|
|`name`|The name of the plugin.|
|`description`|The description of the plugin, shown in the store|