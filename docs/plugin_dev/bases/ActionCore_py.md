`ActionCore` is the base class for **all actions** in [StreamController](https://github.com/StreamController/StreamController). Every action you write extends this class.

It gives you easy access to the input (key, dial or touchscreen) your action is attached to and provides convenient wrappers to change images, set labels, react to input events, store settings and more.

!!! info "`ActionCore` replaces `ActionBase`"
    Up to app version `1.5.0-beta.6` actions extended [`ActionBase`](ActionBase_py.md). Starting with the new input system, `ActionBase` has been **deprecated** and is now only a thin backward-compatibility wrapper around `ActionCore`. New actions should extend `ActionCore`. Existing `ActionBase` actions keep working, see the [legacy note](ActionBase_py.md).

If you want to learn more by going through the code click [here](https://github.com/StreamController/StreamController/blob/main/src/backend/PluginManager/ActionCore.py).

## Anatomy of an action

An action is a subclass of `ActionCore`. You normally forward the constructor arguments untouched using `*args`/`**kwargs`:

```python
from src.backend.PluginManager.ActionCore import ActionCore

class MyAction(ActionCore):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

    def on_ready(self):
        self.set_media(media_path=self.get_asset_path("icon.png"))
```

!!! info "Which input am I attached to?"
    StreamController supports three input types: **keys**, **dials** (rotary encoders, e.g. on the Stream Deck +) and **touchscreens**. The input your action instance is attached to is available as `self.input_ident` and is one of [`Input.Key`](https://github.com/StreamController/StreamController/blob/main/src/backend/DeckManagement/InputIdentifier.py), `Input.Dial` or `Input.Touchscreen`. Which input types your action *supports* is declared on the [`ActionHolder`](../plugin_template/main_py.md) via `action_support`: see [Handling Input & Events](../modify_template/input_events.md).

## Lifecycle hooks

Override these in your action to run your own code. None of them need to call `super()`.

### `on_ready`
: Called once the page is fully loaded and the decks are ready to process requests. **This is the recommended place to set your initial image and labels**: the constructor runs before the decks can render anything.

### `on_update`
: Called when the app wants the action to redraw itself (image, labels, …). By default it simply calls [`on_ready`](#on_ready), so overriding `on_ready` is usually enough. Override `on_update` when you want the redraw path to differ from the initial setup.

### `on_tick`
: Called **every second** to allow live updates.
    !!! warning
        All ticks on the same deck run in the same thread, and the next tick loop starts one second after the last one finished. Do **not** put time-consuming code or precise timing here.

### `on_trigger`
: Generic trigger hook. No-op by default.

### `on_backend_ready`
: Called after a backend launched with [`launch_backend`](#launch_backend) has registered itself.

### `on_remove`
: Called when the action is removed from the input.

### `on_removed_from_cache`
: Called when the action is dropped from the page cache. See [Page Caching](../advanced_concepts/PageCaching.md).

## Handling input events

Instead of overriding fixed `on_key_down`/`on_key_up` methods (the old `ActionBase` way), `ActionCore` uses a flexible **event assigner** system. You register [`EventAssigner`](../modify_template/input_events.md) objects that bind a callback to one or more input events (key press, dial turn, touchscreen drag, …), and the user can remap them in the UI.

This is covered in depth in [Handling Input & Events](../modify_template/input_events.md). The relevant methods are:

### `add_event_assigner`
: **Arguments**:

    |Argument|Type|Description|
    |---|---|---|
    |event_assigner|[EventAssigner](../modify_template/input_events.md)|The event assigner to register.|

    Registers an event handler on this action. Typically called in your constructor.

### `event_callback`
: **Arguments**:

    |Argument|Default|Type|Description|
    |---|---|---|---|
    |event|required|[InputEvent](../modify_template/input_events.md)|The event that occurred.|
    |data|None|dict|Optional event data.|

    A no-op override point that is called for every event. Most actions use [`add_event_assigner`](#add_event_assigner) instead, but you may override this to receive raw events.

The available events are `Input.Key.Events` (`DOWN`, `UP`, `SHORT_UP`, `HOLD_START`, `HOLD_STOP`), `Input.Dial.Events` (the key events plus `TURN_CW`, `TURN_CCW`, `SHORT_TOUCH_PRESS`, `LONG_TOUCH_PRESS`) and `Input.Touchscreen.Events` (`DRAG_LEFT`, `DRAG_RIGHT`).

## Images, media & labels

### `set_media`
: **Arguments**:

    |Argument|Default|Type|Description|
    |---|---|---|---|
    |image|None|[PIL.Image.Image](https://pillow.readthedocs.io/en/stable/reference/Image.html)|An image to display.|
    |media_path|None|str|Path to a media file (image, gif or video).|
    |size|None|float|Size of the media relative to the key.|
    |valign|None|float|Vertical alignment (range -1 to 1).|
    |halign|None|float|Horizontal alignment (range -1 to 1).|
    |fps|30|int|Frames per second for videos.|
    |loop|True|bool|Whether to loop videos.|
    |update|True|bool|Whether to redraw the input immediately.|

    Changes the content shown on the input. Supports images and videos in all major formats. Only applies to `Input.Key` and `Input.Dial` inputs.

### `set_background_color`
: **Arguments**:

    |Argument|Default|Type|Description|
    |---|---|---|---|
    |color|`[0, 0, 0, 0]`|list[int]|RGBA background color.|
    |update|True|bool|Whether to redraw the input immediately.|

    !!! info
        The default changed from `[255, 255, 255, 255]` to a transparent `[0, 0, 0, 0]`. Setting the background only takes effect if this action currently holds background control (see [`has_background_control`](#has_background_control)).

### `set_label`
: **Arguments**:

    |Argument|Default|Type|Description|
    |---|---|---|---|
    |text|required|str|The text to display.|
    |position|"bottom"|str|One of `top`, `center` or `bottom`.|
    |color|None|list[int]|Text color.|
    |font_family|None|str|Font family.|
    |font_size|None|int|Font size.|
    |outline_width|None|int|Width of the text outline.|
    |outline_color|None|list[int]|Color of the text outline.|
    |font_weight|None|int|Font weight.|
    |font_style|None|str|One of `normal`, `italic`, `oblique` or `None`.|
    |update|True|bool|Whether to redraw the input immediately.|

    Writes text in one of the three positions onto the input.
    !!! info "New in the input rework"
        `outline_width`, `outline_color`, `font_weight` and `font_style` were added. The old `stroke_width` argument no longer exists; use `outline_width` instead.

### `set_top_label` / `set_center_label` / `set_bottom_label`
: Convenience wrappers for [`set_label`](#set_label) with `position` fixed to `top`, `center` or `bottom` respectively. They accept the same arguments as `set_label` minus `position`.

### `show_error` / `hide_error`
: **Arguments** (`show_error`):

    |Argument|Default|Type|Description|
    |---|---|---|---|
    |duration|-1|int|How long to show the error, in seconds. `-1` means until hidden.|

    Shows/hides an error indicator on the input.

### `show_overlay` / `hide_overlay`
: **Arguments** (`show_overlay`):

    |Argument|Default|Type|Description|
    |---|---|---|---|
    |image|required|[PIL.Image.Image](https://pillow.readthedocs.io/en/stable/reference/Image.html)|The overlay image.|
    |duration|-1|int|How long to show the overlay, in seconds. `-1` means until hidden.|

    Temporarily draws an overlay on top of the input's current content.

## Configuration UI

### `get_config_rows`
: Override to add configuration rows to the action's config area. **The recommended way to build these rows is the [Generative UI](../modify_template/config/generative_ui.md) system**, which binds widgets to your settings automatically.

    **Returns**: a list of [Adw.PreferencesRow](https://gnome.pages.gitlab.gnome.org/libadwaita/doc/main/class.PreferencesRow.html) objects (e.g. `self.get_generative_ui_widgets()`).

### `get_custom_config_area`
: Override to return any [Gtk.Widget](https://docs.gtk.org/gtk4/class.Widget.html) as a fully custom config area.

The Generative UI plumbing methods (`add_generative_ui_object`, `get_generative_ui_widgets`, `load_initial_generative_ui`) are documented in [Adding Configuration with Generative UI](../modify_template/config/generative_ui.md).

## Settings

### `set_settings`
: **Arguments**:

    |Argument|Type|Description|
    |---|---|---|
    |settings|dict|A dictionary with your settings.|

    Persists the action's settings. The dict is written straight into the page JSON and survives export and duplication:
    ```json hl_lines="4-8"
    "actions": [
                {
                    "name": "dev_core447_MediaPlugin::Info",
                    "settings": {
                        "show_thumbnail": true,
                        "show_label": true,
                        "seperator_text": ""
                    }
                }
            ]
    ```

### `get_settings`
: Returns the settings dictionary previously stored with [`set_settings`](#set_settings).

## Assets, icons & translations

### `get_asset_path`
: **Arguments**:

    |Argument|Default|Type|Description|
    |---|---|---|---|
    |asset_name|required|str|The asset file's name.|
    |subdirs|None|list[str]|Optional subdirectories inside the asset folder.|
    |asset_folder|"assets"|str|Name of the folder assets live in.|

    Returns the absolute path to a file bundled with your plugin (relative to the plugin directory). Handy for [`set_media`](#set_media).

### `get_icon` / `get_color`
: **Arguments**:

    |Argument|Default|Type|Description|
    |---|---|---|---|
    |key|required|str|The asset key registered by the plugin.|
    |skip_override|False|bool|Ignore any user override and return the original asset.|

    Retrieve a shared [icon or color](../modify_template/assets.md) registered by your plugin via `add_icon`/`add_color`. Users can override these per key. See [Icons, Colors & Assets](../modify_template/assets.md).

### `get_translation`
: **Arguments**:

    |Argument|Default|Type|Description|
    |---|---|---|---|
    |key|required|str|The translation key.|
    |fallback|None|str|Value returned if the key is missing.|

    Returns a localized string. See [Localization](../modify_template/localization.md).

## Signals

### `connect`
: **Arguments**:

    |Argument|Default|Type|Description|
    |---|---|---|---|
    |signal|None|[Signal](../modify_template/plugin_events.md)|The signal to connect to.|
    |callback|None|callable|The callback to run.|

    Connects to an app-level [signal](../modify_template/plugin_events.md) (e.g. page rename) so your action can react to changes made through the UI.

## Backends

### `launch_backend`
: **Arguments**:

    |Argument|Default|Type|Description|
    |---|---|---|---|
    |backend_path|required|str|Path of the backend to launch.|
    |venv_path|None|str|Path of the virtual environment to use.|
    |open_in_terminal|False|bool|Launch the backend in a terminal window (useful for debugging).|

    Launches a local backend and waits until it registers. See [BackendBase](BackendBase_py.md).

## Input & permission helpers

Because several actions can share the same input, an action does not always control every aspect of it. These helpers tell you what your action is currently allowed to do and give you access to the underlying input.

### `get_input` / `get_state`
: Return the underlying `ControllerInput` and its current `ControllerInputState`.

### `get_is_present`
: Returns `True` if the action is on the currently active page and visible.

### `get_is_multi_action`
: Returns `True` if more than one action is stacked on this input. When `True`, image operations should generally be skipped.

### `get_own_action_index`
: Returns this action's index within the list of actions on the input.

### `has_image_control` / `has_background_control`
: Return `True` if this action currently controls the input's image / background.

### `has_label_control` / `has_label_controls`
: `has_label_control(label_index)` returns `True` if this action controls the label at the given index (0 = top, 1 = center, 2 = bottom). `has_label_controls()` returns the list of booleans for all three positions.

## Flags

These instance attributes can be set (usually in your constructor) to influence how the action behaves:

### `has_configuration`
: Set to `True` to make StreamController open the configuration page automatically after your action is added to an input. Defaults to `False`.
    !!! info "Renamed"
        This replaces the old `HAS_CONFIGURATION` class constant.

### `allow_event_configuration`
: Set to `False` to hide the per-action event-assignment UI. Defaults to `True`.

### `put_custom_config_rows_below_gen_ui`
: When `True`, rows returned from [`get_config_rows`](#get_config_rows) are placed below the automatically generated Generative UI rows instead of above. Defaults to `False`.
