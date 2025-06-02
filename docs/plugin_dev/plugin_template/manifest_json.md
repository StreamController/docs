# Manifest.json

The [manifest.json](manifest_json.md) file contains information about the plugin.

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

|Name| Description                                                                                                                                                 |
|---|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
|name| The name of you'r Plugin. This will be used everywhere, where the Plugin Name will be displayed                                                             |
|vesrion| The version of the Plugin                                                                                                                                   |
|app-version| The current app version that the Plugin uses                                                                                                                |
|minimum-app-version"|The minumum app version required by the plugin|
|id| The unique id of your plugin in reverse domain name notation. Because Python has problems if the name contains dots, you must replace them with underscores. |
|github| The link to the Plugin's github repository                                                                                                                  |
|thumbnail|The relative path inside the repository to the thumbnail of the plugin|
|descriptions|Localized long descriptions of the plugin|
|short-descriptions|Localized short descriptions of the plugin. Shown in the plugin cards in the store|
|tags|List of tags of the plugin. Not shown in any way atm.|