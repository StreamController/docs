# Manifest.json

The [manifest.json](manifest_json.md) file contains information about the plugin.

## Required Keys
```json title="manifest.json"
{
  "name": "",
  "version": "",
  "app-version": "",
  "id": "",
  "github": ""
}
```

|Name| Description                                                                                                                                                 |
|---|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
|name| The name of you'r Plugin. This will be used everywhere, where the Plugin Name will be displayed                                                             |
|vesrion| The version of the Plugin                                                                                                                                   |
|app-version| The current app version that the Plugin uses                                                                                                                |
|id| The unique id of your plugin in reverse domain name notation. Because Python has problems if the name contains dots, you must replace them with underscores. |
|github| The link to the Plugin's github repository                                                                                                                  |


## Optional Keys
```json title="manifest.json"
{
  "minimum-app-version": "",
  "thumbnail": "",
  "descriptions": {},
  "short-descriptions": {},
  "tags": []
}
```

| Name                | Description                    |
|---------------------|--------------------------------|
| minimum-app-version | The minimum app version the Plugin runs under |
| thumbnail           | The path to the thumbnail file |
| descriptions        | Containing all descriptions that can be shown in the store
| short-descriptions  | Containing all short descriptions that can be shown in the Plugin Preview in the Store
| tags                | Used for filtering Plugins based on provided tags|

### Deprecated Optional Keys

|Name| Description                                                                                                                                                                                                                |
|---|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|description| Used for the description in the store, Deprecated since 1.5.0|
|short-description| Used for the description in the preview, Deprecated since 1.5.0|

## Example Manifest File
```json title="manifest.json"
{
  "name": "Plugin Template",
  "version": "1.0.0",
  "app-version": "1.5.0-beta.6",
  "minimum-app-version": "1.5.0",
  "id": "com_core447_PluginTemplate",
  "github": "https://github.com/StreamController/PluginTemplate",
  "thumbnail": "store/thumbnail.png",
  "descriptions": {
    "en_US": "A Template Manifest file that is very important for the Plugin to load",
    "de_DE": "Die Template manifest datei, welche sehr wichtig ist damit das Plugin laden kann"
  },
  "short-descriptions": {
    "en_US": "A Tempalte Manifest file",
    "de_DE": "Die Template Manifest Datei"
  },
  "tags": [
    "Demo",
    "Useless"
  ]
}
```