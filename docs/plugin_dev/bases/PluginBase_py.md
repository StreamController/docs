`PluginBase` is the base class for all plugins in [StreamController](https://github.com/StreamController/StreamController). Your plugin's `main.py` defines a single subclass of it that registers your actions, backends, assets and pages.

If you want to learn more by going through the code click [here](https://github.com/StreamController/StreamController/blob/main/src/backend/PluginManager/PluginBase.py).

## The constructor

```python
def __init__(self, use_legacy_locale: bool = True, legacy_dir: str = "locales")
```

You override `__init__` in your plugin, register your [action holders](../plugin_template/main_py.md) and call [`register`](#register). When calling `super().__init__()` you can opt into the modern localization system:

|Argument|Default|Type|Description|
|---|---|---|---|
|use_legacy_locale|True|bool|When `True`, translations are read from a `locales/` directory of JSON files (legacy). Pass `False` to use the newer `locales.csv` system.|
|legacy_dir|"locales"|str|The directory used for legacy locales.|

See [Localization](../modify_template/localization.md) for both systems.

## Registering the plugin

### `register`
: **Description**: Registers the plugin with StreamController. Call this at the end of your constructor, after adding your action holders. Any argument left as `None` falls back to the corresponding value in your `manifest.json`.

: **Arguments**:

    |Argument|Default|Description|Type|
    |---|---|---|---|
    |plugin_name|None|The name of the plugin (can be localized).|str|
    |github_repo|None|The link to your GitHub repository.|str|
    |plugin_version|None|The version of the plugin.|str|
    |app_version|None|The StreamController version the plugin targets.|str|

## Registering actions

### `add_action_holder`
: Adds a single [`ActionHolder`](../plugin_template/main_py.md) to the plugin.

    |Argument|Type|Description|
    |---|---|---|
    |action_holder|ActionHolder|The action holder to add.|

### `add_action_holders`
: Adds a list of `ActionHolder`s at once.

    |Argument|Type|Description|
    |---|---|---|
    |action_holders|list[ActionHolder]|The action holders to add.|

### `add_action_holder_group` / `add_action_holder_groups`
: Registers an [`ActionHolderGroup`](../plugin_template/main_py.md) (or a list of them) to group related actions together in the action chooser.

## Plugin events

Plugins can define their own events that other plugins (or their own actions) can subscribe to. This is separate from app-level [Signals](../modify_template/plugin_events.md). See [Plugin Events & Signals](../modify_template/plugin_events.md) for the full picture.

### `add_event_holder` / `add_event_holders`
: Registers an [`EventHolder`](../modify_template/plugin_events.md) (or a list of them) that your plugin can trigger.

### `connect_to_event`
: Subscribes a callback to one of your plugin's events.

    |Argument|Default|Type|Description|
    |---|---|---|---|
    |callback|required|callable|Called when the event triggers.|
    |event_id|None|str|The full event id.|
    |event_id_suffix|None|str|A suffix that is combined with the plugin id to form the full id.|

    !!! warning
        Always pass `event_id` explicitly (the full `"plugin_id::EventName"` form). Note the argument order changed; `callback` now comes first.

### `connect_to_event_directly`
: Subscribes a callback to an event of **another** plugin, identified by `plugin_id` and `event_id`.

### `disconnect_from_event` / `disconnect_from_event_directly`
: Remove a previously connected callback.

## Settings

### `set_settings`
: Stores plugin-wide settings under `.../settings/plugins/<plugin_id>/settings.json`.

    |Argument|Type|Description|
    |---|---|---|
    |settings|dict|The settings to store.|

    !!! info
        The settings file is now versioned (`{"file-version": "2.0", "settings": {…}}`) and older files are migrated automatically on read. Your `get_settings`/`set_settings` usage is unchanged, you still work with the plain settings dict.

### `get_settings`
: Returns the plugin's settings dict (empty dict if none stored yet).

### `has_plugin_settings` / `get_settings_area`
: Set the `self.has_plugin_settings` attribute to `True` and override `get_settings_area()` to return a [Gtk.Widget](https://docs.gtk.org/gtk4/class.Widget.html) to give your plugin its own settings page. You may also override `get_config_rows()` to return plugin-level [Adw.PreferencesRow](https://gnome.pages.gitlab.gnome.org/libadwaita/doc/main/class.PreferencesRow.html)s.

### `first_setup`
: The `self.first_setup` attribute is `True` on the very first launch after installation (until you persist `first-setup: false` in your settings). Use it to run one-time setup.

## Assets (icons & colors)

Register shared icons and colors that your actions can look up and that users can override. See [Icons, Colors & Assets](../modify_template/assets.md).

### `add_icon`
: **Arguments**:

    |Argument|Default|Type|Description|
    |---|---|---|---|
    |key|required|str|The key actions use to look up the icon.|
    |path|required|str|Path to the icon file.|
    |size|1.0|float|Icon size relative to the input.|
    |halign|0.0|float|Horizontal alignment.|
    |valign|0.0|float|Vertical alignment.|

### `add_color`
: **Arguments**:

    |Argument|Type|Description|
    |---|---|---|
    |key|str|The key actions use to look up the color.|
    |color|tuple[int, int, int, int]|The RGBA color.|

### `get_asset_path`
: **Arguments**:

    |Argument|Default|Type|Description|
    |---|---|---|---|
    |asset_name|required|str|The asset file's name.|
    |subdirs|None|list[str]|Optional subdirectories inside the asset folder.|
    |asset_folder|"assets"|str|Name of the folder assets live in.|

    Returns the absolute path to a file bundled with your plugin. The asset manager itself is available as `self.asset_manager` (with `.icons` and `.colors`).

## Pages & styling

### `register_page`
: Registers a page (deck layout) shipped with your plugin so it appears in the UI.

    |Argument|Type|Description|
    |---|---|---|
    |path|str|The path of the page to add.|

### `add_css_stylesheet`
: Loads a CSS stylesheet so your actions can style their config areas.

    |Argument|Type|Description|
    |---|---|---|
    |path|str|The path of the stylesheet to add.|

    !!! warning
        The stylesheet is loaded into the main StreamController window. Prefix all your CSS names uniquely so you don't override existing styles.

### `get_selector_icon`
: Override to return the [Gtk.Widget](https://docs.gtk.org/gtk4/class.Widget.html) used as your plugin's icon in the plugin selector. Defaults to a generic `view-paged` image.

## Backends

### `launch_backend`
: Launches a plugin-wide backend. See [BackendBase](BackendBase_py.md).

    |Argument|Default|Type|Description|
    |---|---|---|---|
    |backend_path|required|str|The path of the backend to launch.|
    |venv_path|None|str|The path of the venv to use.|
    |open_in_terminal|False|bool|Open the backend in a terminal window (useful for debugging).|

## Other useful members

### `get_manifest` / `get_about`
: Return the parsed contents of your plugin's `manifest.json` / `about.json`.

### `get_plugin_id`
: Returns your plugin's id (from the manifest, falling back to the folder name).

### `get_plugin`
: Returns another loaded plugin instance by its id (or `None`).

### `request_dbus_permission`
: Requests a DBus permission from the user (Flatpak). Must be called after [`register`](#register).

    |Argument|Default|Type|Description|
    |---|---|---|---|
    |name|required|str|The bus name.|
    |bus|"session"|str|`"session"` or `"system"`.|
    |description|None|str|Why the permission is needed.|

### `on_uninstall`
: Called when the plugin is uninstalled; unregisters its pages and stops its backend.

### `self.PATH` / `self.logger` / `self.asset_manager`
: Convenience attributes: the plugin's directory on disk, a plugin-scoped logger, and the [asset manager](../modify_template/assets.md).
