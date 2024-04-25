The [manifest.json](manifest_json.md) file contains information about the plugin.


Per default the file looks like this:
```json title="manifest.json"
{
  "version": "",
  "thumbnail": "",
  "id": "",
  "name": "", 
  "app-version": "",
  "author": ""
}
```

As you can see there are six keys you can set.
Those fields are mandatory and need to be included in every Plugin


|Name| Description                                                                                                                                                                                                                |
|---|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|version| The version of your plugin. This has currently no effect at all.                                                                                                                                                           |
|thumbnail| The path to the thumbnail you want to show in the store. This is really important.                                                                                                                                         |
|id| The unique id of your plugin in [reverse domain name notation](https://en.wikipedia.org/wiki/Reverse_domain_name_notation). Because Python has problems if the name contains dots, you must replace them with underscores. |
|name| The name of your plugin. This will only be shown in the store.                                                                                                                                                             |
|app-version| The current app version the Plugin uses|
|author| The creator of the Plugin|


The next 4 keys are optional and dont need to be included in the manifest. Adding them to the manifest would look like this:

```json title="manifest.json"
{
  "app-version": "",
  "descriptions": {
    "en_US": ""
  },
  "short-descriptions": {
    "en_US": ""
  },
  "tags": ["","",""],
  "minimum-app-version": ""
}
```

|Name| Description                                                                                                                                                                                                                |
|---|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|descriptions| Contains all the Descriptions that can be shown in the Store by using the Locales|
|short-descriptions| Contains all the Descriptions that can be shown in the Preview in the Store by using the Locales|
|tags| Can be used to Filter for Plugins|
|minimum-app-version| Specifies a minimum app version the User needs to be running on for the Plugin to function correctly|

The last two keys are optional and dont need to be in the manifest, they are used for backwards compatibility but are not needed with 2.0.0

```json title="manifest.json"
{
  "description": "",
  "short-description": ""
}
```

|Name| Description                                                                                                                                                                                                                |
|---|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|description| Used for the description in the store, Deprecated since 2.0.0|
|short-description| Used for the description in the preview, Deprecated since 2.0.0|