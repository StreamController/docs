The [PluginBase](PluginBase_py.md) is the base for all plugins in [StreamController](https://github.com/Core447/StreamController).

If you want to learn more by going throught the code click [here](https://github.com/Core447/StreamController/blob/main/src/backend/PluginManager/PluginBase.py).

## Available methods
### `register`
: **Description**:
    Registers the plugin.

: **Arguments**:

    |Argument|Default|Description|Type|
    |---|---|---|---|
    |plugin_name|None|The name of the plugin. (can be localized)|str|
    |github_repo|None|The link to your github repository.|str|
    |plugin_version|None|The version of the plugin.|str|
    |app_version|None|The version of the app the plugin is compatible with.|str|

### `do_versions_match`
: **Description**:
    Checks if the version of the plugin and the app are compatible.
    !!! info
        This is an internal method and there should be no need to use it manually

: **Arguments**:

    |Argument|Default|Description|Type|
    |---|---|---|---|
    |app_version_to_check|None|The version of the app to check.|str|

### `add_action_holder`
: **Description**:
    Adds an action holder to the plugin.

: **Arguments**:

    |Argument|Default|Description|Type|
    |---|---|---|---|
    |action_holder|None|The action holder to add.|ActionHolder|

### `set_settings`
: **Description**:

    This settings stores plugin specific settings under `plugin_dir/settings.json`

: **Arguments**:

    |Argument|Default|Description|Type|
    |---|---|---|---|
    |settings|None|The settings to store.|dict|

### `get_settings`
: **Description**:  

    This method returns a dictionary with all your set settings for this plugin.
    For more see [`set_settings`](#set_settings).

### `add_css_stylesheet`
: **Description**:

    Adds a css stylesheet to the plugin, allowing actions to further style their config areas.

    !!! warning
        The stylesheet will be loaded to the main StreamController window. Be careful to not override any existing styles. Therefore it is recomended to start all names with an unique prefix.

: **Arguments**:

    |Argument|Default|Description|Type|
    |---|---|---|---|
    |path|None|The path of the stylesheet to add.|str|

### `register_page`
: **Description**:

    Adds a page to StreamController.

: **Arguments**:

    |Argument|Default|Description|Type|
    |---|---|---|---|
    |path|None|The path of the page to add.|str|

### `launch_backend`
: **Description**:

    Launches a plugin wide backend. See [BackendBase](../bases/BackendBase_py.md).

: **Arguments**:

    |Argument|Default|Description|Type|
    |---|---|---|---|
    |backend_path|None|The path of the backend to launch.|str|
    |venv_path|None|The path of the venv to use.|str|
    |open_in_terminal|False|Open the backend in a terminal window. Useful for debugging.|bool

### `get_selector_image`
: **Description**:

    Returns the icon used for the plugin selector in the ui.

### `on_uninstall`
: **Description**:

    Disconnects and stops own backend if launched.