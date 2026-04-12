The [PluginBase](PluginBase_py.md) is the base for all plugins in [StreamController](https://github.com/StreamController/StreamController).

If you want to learn more by going through the code click [here](https://github.com/StreamController/StreamController/blob/main/src/backend/PluginManager/PluginBase.py).

## Constructor

```python
class MyPlugin(PluginBase):
    def __init__(self):
        super().__init__()
```

The constructor accepts an optional parameter:

| Parameter | Default | Description |
|-----------|---------|-------------|
| `use_legacy_locale` | `True` | Set to `False` to use CSV-based localization instead of JSON |

```python
class MyPlugin(PluginBase):
    def __init__(self):
        super().__init__()
        # For CSV localization, just use the locale_manager directly
        self.lm = self.locale_manager
        self.lm.set_to_os_default()
```

## Properties

### `locale_manager`
: The locale manager for handling translations. Access with `self.locale_manager` or create a shorthand like `self.lm = self.locale_manager`.

### `asset_manager`
: Manages icons and colors registered with the plugin. Access registered assets via `self.asset_manager.icons` and `self.asset_manager.colors`.

### `backend`
: The RPyC backend connection if `launch_backend()` was called. Use to call methods on your backend.

### `PATH`
: The absolute path to your plugin's directory.

## Available Methods

### `register`
: **Description**:
    Registers the plugin with StreamController.

: **Arguments**:

    |Argument|Default|Description|Type|
    |---|---|---|---|
    |plugin_name|None|The name of the plugin (can be localized)|str|
    |github_repo|None|The link to your github repository|str|
    |plugin_version|None|The version of the plugin|str|
    |app_version|None|The minimum StreamController version required|str|

### `add_action_holder`
: **Description**:
    Adds an action holder to the plugin, making the action available in the UI.

: **Arguments**:

    |Argument|Default|Description|Type|
    |---|---|---|---|
    |action_holder|None|The action holder to add|ActionHolder|

### `add_action_holders`
: **Description**:
    Adds multiple action holders at once.

: **Arguments**:

    |Argument|Default|Description|Type|
    |---|---|---|---|
    |action_holders|None|List of action holders to add|list[ActionHolder]|

### `add_action_holder_group`
: **Description**:
    Adds a group of related actions that will be displayed together in the UI.

: **Arguments**:

    |Argument|Default|Description|Type|
    |---|---|---|---|
    |action_holder_group|None|The action holder group to add|ActionHolderGroup|

### `add_icon`
: **Description**:
    Registers an icon with the plugin's asset manager for use in actions.

: **Arguments**:

    |Argument|Default|Description|Type|
    |---|---|---|---|
    |key|None|Unique identifier for the icon|str|
    |path|None|Path to the icon file|str|

    ```python
    def __init__(self):
        super().__init__()
        self.add_icon("main", self.get_asset_path("icon.png"))
        self.add_icon("muted", self.get_asset_path("muted.png"))
    ```

### `add_color`
: **Description**:
    Registers a color with the plugin's asset manager for use in actions.

: **Arguments**:

    |Argument|Default|Description|Type|
    |---|---|---|---|
    |key|None|Unique identifier for the color|str|
    |color|None|RGBA color values (0-255)|list[int]|

    ```python
    def __init__(self):
        super().__init__()
        self.add_color("default", [0, 0, 0, 0])
        self.add_color("warning", [255, 244, 79, 255])
    ```

### `get_asset_path`
: **Description**:
    Helper method to construct paths to plugin assets.

: **Arguments**:

    |Argument|Default|Description|Type|
    |---|---|---|---|
    |asset_name|None|Name of the asset file|str|
    |subdirs|None|List of subdirectories|list[str]|
    |asset_folder|"assets"|Name of the assets folder|str|

: **Returns**: `str` - Full path to the asset

    ```python
    icon_path = self.get_asset_path("icon.png")
    # Returns: /path/to/plugin/assets/icon.png
    ```

### `set_settings`
: **Description**:
    Stores plugin-specific settings under `plugin_dir/settings.json`.

: **Arguments**:

    |Argument|Default|Description|Type|
    |---|---|---|---|
    |settings|None|The settings to store|dict|

### `get_settings`
: **Description**:  
    Returns a dictionary with all stored settings for this plugin.
    See [`set_settings`](#set_settings).

### `add_css_stylesheet`
: **Description**:
    Adds a CSS stylesheet to the plugin, allowing actions to further style their config areas.

    !!! warning
        The stylesheet will be loaded to the main StreamController window. Be careful to not override any existing styles. It is recommended to start all class names with a unique prefix.

: **Arguments**:

    |Argument|Default|Description|Type|
    |---|---|---|---|
    |path|None|The path of the stylesheet to add|str|

### `register_page`
: **Description**:
    Adds a page to StreamController.

: **Arguments**:

    |Argument|Default|Description|Type|
    |---|---|---|---|
    |path|None|The path of the page to add|str|

### `launch_backend`
: **Description**:
    Launches a plugin-wide backend process. See [BackendBase](../bases/BackendBase_py.md).

    After launching, access the backend via `self.backend`:
    ```python
    result = self.backend.some_method()
    ```

: **Arguments**:

    |Argument|Default|Description|Type|
    |---|---|---|---|
    |backend_path|None|The path of the backend to launch|str|
    |venv_path|None|The path of the venv to use|str|
    |open_in_terminal|False|Open the backend in a terminal window (useful for debugging)|bool|

### `get_selector_image`
: **Description**:
    Returns the icon used for the plugin selector in the UI.

### `on_uninstall`
: **Description**:
    Called when the plugin is uninstalled. Disconnects and stops the backend if launched.

### `do_versions_match`
: **Description**:
    Checks if the version of the plugin and the app are compatible.
    
    !!! info
        This is an internal method and there should be no need to use it manually.

: **Arguments**:

    |Argument|Default|Description|Type|
    |---|---|---|---|
    |app_version_to_check|None|The version of the app to check|str|

## Plugin Settings UI

Plugins can provide a settings page accessible from the plugin list:

```python
class MyPlugin(PluginBase):
    def __init__(self):
        super().__init__()
        self.has_plugin_settings = True  # Enable settings button
    
    def get_settings_area(self) -> Adw.PreferencesGroup:
        pref_group = Adw.PreferencesGroup()
        pref_group.set_title("My Plugin Settings")
        
        # Add your settings widgets here
        
        return pref_group
```
