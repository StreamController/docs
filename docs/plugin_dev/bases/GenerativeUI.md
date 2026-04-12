GenerativeUI is a system for creating configuration widgets that automatically save and load their values from the action's settings. This eliminates boilerplate code for managing config state.

## Why GenerativeUI?

**Without GenerativeUI** (manual approach):
```python
def get_config_rows(self) -> list:
    self.spinner = Adw.SpinRow.new_with_range(1, 100, 1)
    self.spinner.set_title("Count")
    
    # Load saved value
    settings = self.get_settings()
    self.spinner.set_value(settings.get("count", 1))
    
    # Save on change
    self.spinner.connect("changed", self.on_spinner_changed)
    
    return [self.spinner]

def on_spinner_changed(self, spinner):
    settings = self.get_settings()
    settings["count"] = int(spinner.get_value())
    self.set_settings(settings)
```

**With GenerativeUI**:
```python
def __init__(self, *args, **kwargs):
    super().__init__(*args, **kwargs)
    self.count_row = SpinRow(
        action_core=self,
        var_name="count",
        default_value=1,
        title="Count",
        min=1, max=100, step=1
    )

def get_config_rows(self) -> list:
    return [self.count_row.widget]
```

## Available Widgets

All widgets are in `GtkHelper.GenerativeUI`:

```python
from GtkHelper.GenerativeUI.EntryRow import EntryRow
from GtkHelper.GenerativeUI.SpinRow import SpinRow
from GtkHelper.GenerativeUI.SwitchRow import SwitchRow
# etc.
```

| Widget | Purpose | Value Type |
|--------|---------|------------|
| `EntryRow` | Text input | `str` |
| `SpinRow` | Numeric spinner | `int` or `float` |
| `SwitchRow` | Toggle switch | `bool` |
| `ComboRow` | Dropdown select | varies |
| `ScaleRow` | Slider | `float` |
| `ColorButtonRow` | Color picker | `list[int]` (RGBA) |
| `PasswordEntryRow` | Password input | `str` |
| `FileDialogRow` | File chooser | `str` (path) |
| `ToggleRow` | Toggle button | `bool` |
| `ExpanderRow` | Expandable section | N/A (container) |

## Common Parameters

All GenerativeUI widgets share these constructor parameters:

| Parameter | Type | Description |
|-----------|------|-------------|
| `action_core` | `ActionCore` | The action this widget belongs to |
| `var_name` | `str` | Key used in settings dict |
| `default_value` | varies | Default value if not set |
| `can_reset` | `bool` | Show reset button (default: `True`) |
| `auto_add` | `bool` | Auto-register with action (default: `True`) |
| `complex_var_name` | `bool` | Enable dot notation (default: `False`) |
| `on_change` | `callable` | Callback when value changes |

## Widget Reference

### EntryRow

Text input field.

```python
from GtkHelper.GenerativeUI.EntryRow import EntryRow

self.name_row = EntryRow(
    action_core=self,
    var_name="username",
    default_value="",
    title="Username",
    filter_func=lambda s: s.lower()  # Optional: transform input
)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `title` | `str` | Row title (can be a translation key) |
| `filter_func` | `callable` | Function to filter/transform text |

### SpinRow

Numeric spinner with increment/decrement.

```python
from GtkHelper.GenerativeUI.SpinRow import SpinRow

self.count_row = SpinRow(
    action_core=self,
    var_name="count",
    default_value=10,
    title="Count",
    min=1,
    max=100,
    step=1
)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `title` | `str` | Row title |
| `min` | `int/float` | Minimum value |
| `max` | `int/float` | Maximum value |
| `step` | `int/float` | Increment step |

### SwitchRow

Toggle switch for boolean values.

```python
from GtkHelper.GenerativeUI.SwitchRow import SwitchRow

self.enabled_row = SwitchRow(
    action_core=self,
    var_name="enabled",
    default_value=True,
    title="Enable Feature"
)
```

### ComboRow

Dropdown selection.

```python
from GtkHelper.GenerativeUI.ComboRow import ComboRow

self.mode_row = ComboRow(
    action_core=self,
    var_name="mode",
    default_value="auto",
    title="Mode",
    options=[
        ("auto", "Automatic"),
        ("manual", "Manual"),
        ("disabled", "Disabled")
    ]
)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `options` | `list[tuple]` | List of `(value, label)` tuples |

### ScaleRow

Slider for continuous values.

```python
from GtkHelper.GenerativeUI.ScaleRow import ScaleRow

self.volume_row = ScaleRow(
    action_core=self,
    var_name="volume",
    default_value=50,
    title="Volume",
    min=0,
    max=100,
    step=1
)
```

### ColorButtonRow

Color picker.

```python
from GtkHelper.GenerativeUI.ColorButtonRow import ColorButtonRow

self.color_row = ColorButtonRow(
    action_core=self,
    var_name="highlight_color",
    default_value=[255, 0, 0, 255],  # RGBA
    title="Highlight Color"
)
```

### PasswordEntryRow

Password input with hidden text.

```python
from GtkHelper.GenerativeUI.PasswordEntryRow import PasswordEntryRow

self.api_key_row = PasswordEntryRow(
    action_core=self,
    var_name="api_key",
    default_value="",
    title="API Key"
)
```

### FileDialogRow

File chooser dialog.

```python
from GtkHelper.GenerativeUI.FileDialogRow import FileDialogRow

self.file_row = FileDialogRow(
    action_core=self,
    var_name="script_path",
    default_value="",
    title="Script File"
)
```

## Using Widgets in Actions

### Basic Pattern

```python
from src.backend.PluginManager.ActionCore import ActionCore
from src.backend.PluginManager.EventAssigner import EventAssigner
from src.backend.DeckManagement.InputIdentifier import Input
from GtkHelper.GenerativeUI.EntryRow import EntryRow
from GtkHelper.GenerativeUI.SwitchRow import SwitchRow

class MyAction(ActionCore):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.has_configuration = True  # Enable config UI
        
        self.add_event_assigner(EventAssigner(
            id="key-down",
            ui_label="Key Down",
            default_event=Input.Key.Events.DOWN,
            callback=self.on_key_down
        ))
        
        self.message_row = EntryRow(
            action_core=self,
            var_name="message",
            default_value="Hello",
            title="Message"
        )
        
        self.show_time_row = SwitchRow(
            action_core=self,
            var_name="show_time",
            default_value=False,
            title="Show Timestamp"
        )
    
    def get_config_rows(self) -> list:
        return [
            self.message_row.widget,
            self.show_time_row.widget
        ]
    
    def on_key_down(self):
        message = self.message_row.get_value()
        if self.show_time_row.get_value():
            message = f"[{time.strftime('%H:%M')}] {message}"
        print(message)
```

### Accessing Values

```python
# Get current value
value = self.message_row.get_value()

# Set value programmatically
self.message_row.set_value("New message")

# Reset to default
self.message_row.reset_value()
```

### Change Callbacks

React to value changes:

```python
self.volume_row = SpinRow(
    action_core=self,
    var_name="volume",
    default_value=50,
    title="Volume",
    min=0, max=100, step=1,
    on_change=self.on_volume_change
)

def on_volume_change(self, widget, new_value, old_value):
    self.backend.set_volume(new_value)
    self.set_center_label(f"{new_value}%")
```

## Nested Settings

Use `complex_var_name=True` for nested settings structures:

```python
self.channel_row = EntryRow(
    action_core=self,
    var_name="twitch.channel_name",
    default_value="",
    title="Channel",
    complex_var_name=True
)

self.message_row = EntryRow(
    action_core=self,
    var_name="twitch.message",
    default_value="",
    title="Message",
    complex_var_name=True
)
```

This creates nested settings:
```json
{
    "twitch": {
        "channel_name": "mychannel",
        "message": "Hello chat!"
    }
}
```

## Localization

Widget titles can use translation keys:

```python
self.message_row = EntryRow(
    action_core=self,
    var_name="message",
    default_value="",
    title="action.message.title"  # Translation key
)
```

The widget automatically looks up the translation using `action_core.get_translation()`.

## Disabling Reset Button

```python
self.api_key_row = PasswordEntryRow(
    action_core=self,
    var_name="api_key",
    default_value="",
    title="API Key",
    can_reset=False  # No reset button
)
```

## Manual Widget Control

If you need more control, set `auto_add=False`:

```python
self.custom_row = EntryRow(
    action_core=self,
    var_name="custom",
    default_value="",
    title="Custom",
    auto_add=False
)

# Manually manage the widget lifecycle
def get_config_rows(self) -> list:
    self.custom_row.load_ui_value()  # Manually load value
    return [self.custom_row.widget]
```

## Complete Example

```python
from src.backend.PluginManager.ActionCore import ActionCore
from src.backend.PluginManager.EventAssigner import EventAssigner
from src.backend.DeckManagement.InputIdentifier import Input
from GtkHelper.GenerativeUI.EntryRow import EntryRow
from GtkHelper.GenerativeUI.SpinRow import SpinRow
from GtkHelper.GenerativeUI.SwitchRow import SwitchRow
from GtkHelper.GenerativeUI.ComboRow import ComboRow

class NotificationAction(ActionCore):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.has_configuration = True
        
        self.add_event_assigner(EventAssigner(
            id="key-down",
            ui_label="Key Down",
            default_event=Input.Key.Events.DOWN,
            callback=self.on_key_down
        ))
        
        self.title_row = EntryRow(
            action_core=self,
            var_name="notification.title",
            default_value="Alert",
            title="Title",
            complex_var_name=True
        )
        
        self.body_row = EntryRow(
            action_core=self,
            var_name="notification.body",
            default_value="",
            title="Body",
            complex_var_name=True
        )
        
        self.duration_row = SpinRow(
            action_core=self,
            var_name="duration",
            default_value=5,
            title="Duration (seconds)",
            min=1, max=30, step=1
        )
        
        self.sound_row = SwitchRow(
            action_core=self,
            var_name="play_sound",
            default_value=True,
            title="Play Sound"
        )
        
        self.urgency_row = ComboRow(
            action_core=self,
            var_name="urgency",
            default_value="normal",
            title="Urgency",
            options=[
                ("low", "Low"),
                ("normal", "Normal"),
                ("critical", "Critical")
            ]
        )
    
    def get_config_rows(self) -> list:
        return [
            self.title_row.widget,
            self.body_row.widget,
            self.duration_row.widget,
            self.sound_row.widget,
            self.urgency_row.widget
        ]
    
    def on_key_down(self):
        self.backend.send_notification(
            title=self.title_row.get_value(),
            body=self.body_row.get_value(),
            duration=self.duration_row.get_value(),
            sound=self.sound_row.get_value(),
            urgency=self.urgency_row.get_value()
        )
```
