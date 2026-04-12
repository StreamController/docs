```python title="SimpleAction.py"
# Import StreamController modules
from src.backend.PluginManager.ActionCore import ActionCore #(1)!
from src.backend.PluginManager.EventAssigner import EventAssigner
from src.backend.DeckManagement.InputIdentifier import Input

# Import python modules
import os

class SimpleAction(ActionCore):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        
        self.add_event_assigner(EventAssigner( #(2)!
            id="key-down",
            ui_label="Key Down",
            default_event=Input.Key.Events.DOWN,
            callback=self.on_key_down
        ))
        
        self.add_event_assigner(EventAssigner(
            id="key-up",
            ui_label="Key Up",
            default_event=Input.Key.Events.UP,
            callback=self.on_key_up
        ))
        
    def on_ready(self) -> None:
        icon_path = os.path.join(self.plugin_base.PATH, "assets", "info.png")
        self.set_media(media_path=icon_path, size=0.75) #(3)!
        
    def on_key_down(self) -> None:
        print("Key down") #(4)!
    
    def on_key_up(self) -> None:
        print("Key up") #(5)!
```

1. Import [ActionCore](../bases/ActionCore_py.md) and [EventAssigner](../bases/EventSystem.md) for event handling
2. Register event handlers using `add_event_assigner()` - this maps input events to callbacks
3. Set an icon for the action in `on_ready()` (not in `__init__`)
4. Called when the key is pressed
5. Called when the key is released

## Understanding the Code

### Imports

```python
from src.backend.PluginManager.ActionCore import ActionCore
from src.backend.PluginManager.EventAssigner import EventAssigner
from src.backend.DeckManagement.InputIdentifier import Input
```

- [ActionCore](../bases/ActionCore_py.md) is the base class for all actions
- [EventAssigner](../bases/EventSystem.md) maps input events to callback functions
- `Input` provides constants for input types and events

### The Action Class

```python
class SimpleAction(ActionCore):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
```

Your action extends `ActionCore`. The `*args, **kwargs` pattern lets the framework pass required parameters without you needing to specify them.

### Registering Event Handlers

```python
self.add_event_assigner(EventAssigner(
    id="key-down",
    ui_label="Key Down",
    default_event=Input.Key.Events.DOWN,
    callback=self.on_key_down
))
```

Use `add_event_assigner()` to register callbacks for input events. Each `EventAssigner` needs:

| Parameter | Description |
|-----------|-------------|
| `id` | Unique identifier for this event handler |
| `ui_label` | Label shown in the UI |
| `default_event` | The input event to respond to |
| `callback` | Function to call when event fires |

### Setting the Icon

```python
def on_ready(self) -> None:
    icon_path = os.path.join(self.plugin_base.PATH, "assets", "info.png")
    self.set_media(media_path=icon_path, size=0.75)
```

!!! warning
    Always set images in `on_ready()`, not `__init__()`. The deck isn't ready to process image changes during construction.

You can also use the helper method:
```python
def on_ready(self) -> None:
    self.set_media(media_path=self.get_asset_path("info.png"), size=0.75)
```

### Handling Events

```python
def on_key_down(self) -> None:
    print("Key down")

def on_key_up(self) -> None:
    print("Key up")
```

These methods are called when the corresponding `EventAssigner` triggers.

### Common Key Events

| Event | Description |
|-------|-------------|
| `Input.Key.Events.DOWN` | Key pressed |
| `Input.Key.Events.UP` | Key released |
| `Input.Key.Events.SHORT_UP` | Quick tap (no hold) |
| `Input.Key.Events.HOLD_START` | Hold begins |
| `Input.Key.Events.HOLD_STOP` | Hold ends |

See [Event System](../bases/EventSystem.md) for more details on available events and dial/touchscreen support.
