The Event System allows actions to respond to hardware inputs (key presses, dial rotations, touchscreen swipes) in a flexible and user-configurable way.

## Overview

When a user interacts with a Stream Deck, the hardware generates **input events**. These events are routed through **EventAssigners** to your action's callback methods. Users can remap events in the UI, allowing them to customize how actions respond to inputs.

```
Hardware Input → Input Event → EventAssigner → Your Callback
                                    ↑
                            (User can remap)
```

## EventAssigner

The `EventAssigner` class maps input events to callback functions.

```python
from src.backend.PluginManager.EventAssigner import EventAssigner
from src.backend.DeckManagement.InputIdentifier import Input

self.add_event_assigner(EventAssigner(
    id="my-action",
    ui_label="Do Something",
    default_event=Input.Key.Events.DOWN,
    callback=self.do_something
))
```

### Constructor

| Argument | Type | Description |
|----------|------|-------------|
| `id` | `str` | Unique identifier for this event assigner |
| `ui_label` | `str` | Label displayed in the UI for event remapping |
| `callback` | `callable` | Function to call when the event fires |
| `default_event` | `InputEvent` | Single default event (use this OR `default_events`) |
| `default_events` | `list[InputEvent]` | Multiple default events |
| `tooltip` | `str` | Optional tooltip shown in UI |

### Multiple Events

You can map multiple events to the same callback:

```python
self.add_event_assigner(EventAssigner(
    id="activate",
    ui_label="Activate",
    default_events=[
        Input.Key.Events.DOWN,
        Input.Dial.Events.DOWN
    ],
    callback=self.activate
))
```

## Input Events Reference

### Key Events

Available via `Input.Key.Events.*`:

| Event | Description |
|-------|-------------|
| `DOWN` | Key pressed down |
| `UP` | Key released |
| `SHORT_UP` | Quick tap (released without hold) |
| `HOLD_START` | Hold begins (after holding threshold) |
| `HOLD_STOP` | Hold ends |

### Dial Events

Available via `Input.Dial.Events.*`:

| Event | Description |
|-------|-------------|
| `DOWN` | Dial pressed down |
| `UP` | Dial released |
| `SHORT_UP` | Quick tap |
| `HOLD_START` | Hold begins |
| `HOLD_STOP` | Hold ends |
| `TURN_CW` | Clockwise rotation |
| `TURN_CCW` | Counter-clockwise rotation |
| `SHORT_TOUCH_PRESS` | Quick tap on touchscreen above dial |
| `LONG_TOUCH_PRESS` | Long press on touchscreen above dial |

### Touchscreen Events

Available via `Input.Touchscreen.Events.*`:

| Event | Description |
|-------|-------------|
| `DRAG_LEFT` | Swipe left |
| `DRAG_RIGHT` | Swipe right |

## Registering Events

Register event handlers in your action's `__init__` method using `add_event_assigner()`:

```python
from src.backend.PluginManager.ActionCore import ActionCore
from src.backend.PluginManager.EventAssigner import EventAssigner
from src.backend.DeckManagement.InputIdentifier import Input

class MyAction(ActionCore):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        
        self.add_event_assigner(EventAssigner(
            id="toggle",
            ui_label="Toggle State",
            default_event=Input.Key.Events.DOWN,
            callback=self.toggle
        ))
        
        self.add_event_assigner(EventAssigner(
            id="reset",
            ui_label="Reset",
            default_event=Input.Key.Events.HOLD_START,
            callback=self.reset,
            tooltip="Hold to reset"
        ))
    
    def toggle(self):
        # Called on key press
        pass
    
    def reset(self):
        # Called when hold starts
        pass
```

## Callback Arguments

Some callbacks receive additional data:

```python
def on_dial_turn(self, data: dict):
    # data may contain rotation amount, direction, etc.
    pass
```

For most key events, callbacks receive no arguments or can ignore them:

```python
def on_key_down(self):
    pass

# Or with optional data parameter
def on_key_down(self, data=None):
    pass
```

## Disabling Event Configuration

By default, users can remap events in the UI. To disable this:

```python
class MyAction(ActionCore):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.allow_event_configuration = False
```

## Example: Volume Control

A complete example showing dial events for volume control:

```python
from src.backend.PluginManager.ActionCore import ActionCore
from src.backend.PluginManager.EventAssigner import EventAssigner
from src.backend.DeckManagement.InputIdentifier import Input

class VolumeControl(ActionCore):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.volume = 50
        
        self.add_event_assigner(EventAssigner(
            id="volume-up",
            ui_label="Volume Up",
            default_event=Input.Dial.Events.TURN_CW,
            callback=self.volume_up
        ))
        
        self.add_event_assigner(EventAssigner(
            id="volume-down",
            ui_label="Volume Down",
            default_event=Input.Dial.Events.TURN_CCW,
            callback=self.volume_down
        ))
        
        self.add_event_assigner(EventAssigner(
            id="toggle-mute",
            ui_label="Toggle Mute",
            default_event=Input.Dial.Events.DOWN,
            callback=self.toggle_mute
        ))
    
    def on_ready(self):
        self.update_display()
    
    def volume_up(self):
        self.volume = min(100, self.volume + 5)
        self.update_display()
        self.backend.set_volume(self.volume)
    
    def volume_down(self):
        self.volume = max(0, self.volume - 5)
        self.update_display()
        self.backend.set_volume(self.volume)
    
    def toggle_mute(self):
        self.backend.toggle_mute()
    
    def update_display(self):
        self.set_center_label(f"{self.volume}%")
```

## Example: Multi-Function Key

A key with different actions for tap vs hold:

```python
from src.backend.PluginManager.ActionCore import ActionCore
from src.backend.PluginManager.EventAssigner import EventAssigner
from src.backend.DeckManagement.InputIdentifier import Input

class MultiFunction(ActionCore):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        
        # Tap to play/pause
        self.add_event_assigner(EventAssigner(
            id="play-pause",
            ui_label="Play/Pause",
            default_event=Input.Key.Events.SHORT_UP,
            callback=self.play_pause
        ))
        
        # Hold to skip
        self.add_event_assigner(EventAssigner(
            id="skip",
            ui_label="Skip Track",
            default_event=Input.Key.Events.HOLD_START,
            callback=self.skip_track
        ))
    
    def play_pause(self):
        self.backend.toggle_playback()
    
    def skip_track(self):
        self.backend.next_track()
```
