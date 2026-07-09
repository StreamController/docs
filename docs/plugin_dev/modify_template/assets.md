# Icons & Colors

In [Draw an Icon](../plugin_template/SimpleAction_py.md) we loaded an image straight from a file path. That works, but it means only *you* can choose the icon. If you register icons and colors as **shared assets** instead, users can swap them from the UI to match their own setup.

Plugins register shared **icons** and **colors** under string keys. Actions look them up by key instead of hard-coding file paths or RGBA tuples, and — importantly — the user can override any registered asset from the UI. This is how a plugin offers a consistent, themeable set of visuals that users can customize.

## Registering assets

Register your icons and colors on the [plugin](../bases/PluginBase_py.md), usually while initializing the plugin:

```python
class MyPlugin(PluginBase):
    def __init__(self):
        super().__init__()

        self.add_icon(
            key="volume_up",
            path=self.get_asset_path("volume_up.png"),
            size=0.75
        )
        self.add_color(
            key="accent",
            color=(0, 120, 255, 255)
        )

        # ... register action holders, then self.register(...)
```

### `add_icon`

|Argument|Default|Description|
|---|---|---|
|key|—|The key actions use to look up the icon.|
|path|—|Path to the icon file (use [`get_asset_path`](../bases/PluginBase_py.md#get_asset_path)).|
|size|1.0|Icon size relative to the input.|
|halign|0.0|Horizontal alignment.|
|valign|0.0|Vertical alignment.|

### `add_color`

|Argument|Description|
|---|---|
|key|The key actions use to look up the color.|
|color|An RGBA tuple `(r, g, b, a)`.|

## Using assets in an action

Actions retrieve assets with [`get_icon`](../bases/ActionCore_py.md#get_icon-get_color) and [`get_color`](../bases/ActionCore_py.md#get_icon-get_color):

```python
class VolumeUp(ActionCore):
    def on_ready(self):
        icon = self.get_icon("volume_up")
        if icon is not None:
            image, rendered = icon.get_values()
            self.set_media(image=rendered)
```

`get_icon`/`get_color` return the user-overridden asset if one exists. Pass `skip_override=True` to get the original asset your plugin registered.

## User overrides

Because assets are registered by key, StreamController lets the user replace them (a different icon, a different color) without touching your code. Overrides are stored per key in your plugin's `settings.json` under an `"assets"` section and are applied automatically the next time `get_icon`/`get_color` is called.

If you need to react when the user changes an override — for example to redraw immediately — subscribe to the asset manager:

```python
self.plugin_base.asset_manager.icons.add_listener(self.on_icons_changed)

def on_icons_changed(self, *args):
    self.on_ready()  # redraw with the new icon
```

The asset manager is available as `self.asset_manager` on the plugin (`.icons` and `.colors`), and as `self.plugin_base.asset_manager` from an action.
