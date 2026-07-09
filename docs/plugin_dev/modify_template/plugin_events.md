StreamController has **two** distinct event systems, and it's easy to confuse them:

- **Plugin events** ([`EventHolder`](#plugin-events)), events *your* plugin defines and triggers, that your own actions or other plugins can subscribe to.
- **App signals** ([`Signal`](#app-signals)), events *the app* emits when something happens in the UI (a page is renamed, a plugin is installed, …).

## Plugin events

A plugin event lets one part of your plugin (or another plugin entirely) notify others when something happens, for example a backend detecting that an audio device changed.

### Defining an event

Register an [`EventHolder`](https://github.com/StreamController/StreamController/blob/main/src/backend/PluginManager/EventHolder.py) on your plugin:

```python
from src.backend.PluginManager.EventHolder import EventHolder

class MyPlugin(PluginBase):
    def __init__(self):
        super().__init__()

        self.device_changed_event = EventHolder(
            plugin_base=self,
            event_id_suffix="DeviceChanged"   # -> "<plugin_id>::DeviceChanged"
        )
        self.add_event_holder(self.device_changed_event)
```

`EventHolder` takes either a full `event_id` or an `event_id_suffix` that is combined with your plugin id.

### Triggering an event

```python
self.device_changed_event.trigger_event(device_name)
```

All subscribed callbacks are called with the arguments you pass (both plain functions and `async` coroutines are supported).

### Subscribing to an event

From your own actions or plugin, subscribe with [`connect_to_event`](../bases/PluginBase_py.md#connect_to_event):

```python
self.plugin_base.connect_to_event(
    event_id="com_example_MyPlugin::DeviceChanged",
    callback=self.on_device_changed
)

def on_device_changed(self, device_name):
    ...
```

!!! warning "Pass `event_id` explicitly"
    The argument order is `connect_to_event(callback, event_id=None, event_id_suffix=None)`. Always pass the full `event_id` as a keyword. To subscribe to **another** plugin's event, use [`connect_to_event_directly(plugin_id, event_id, callback)`](../bases/PluginBase_py.md#connect_to_event_directly).

## App signals

App signals fire when the user performs certain actions in the UI. A typical use: your action stores a page path in its settings and needs to update it when the page is renamed.

### Available signals

|Signal|Fires when…|Callback arguments|
|---|---|---|
|`PageRename`|A page is renamed.|`old_path: str`, `new_path: str`|
|`PageDelete`|A page is deleted.|`path: str`|
|`PageAdd`|A page is added.|`path: str`|
|`ChangePage`|A deck switches page.|`controller: DeckController`, `old_path: str`, `new_path: str`|
|`PluginInstall`|A plugin is installed.|`id: str`|
|`AppQuit`|The app is shutting down.|none|
|`RemoveState`|An action state is removed.|`state: int`, `state_map: dict`|

### Connecting to a signal

```python
from src.Signals import Signals

# inside your action:
self.connect(signal=Signals.PageRename, callback=self.on_page_rename)

def on_page_rename(self, old_path, new_path):
    ...
```

[`connect`](../bases/ActionCore_py.md#connect) is available on every [`ActionCore`](../bases/ActionCore_py.md). From a plugin (or anywhere else) you can use `gl.signal_manager.connect_signal(Signals.AppQuit, self.on_quit)` directly.

### Not enough?

If you need a signal that doesn't exist yet, feel free to open an [issue](https://github.com/StreamController/StreamController/issues) or a [pull request](https://github.com/StreamController/StreamController/pulls).
