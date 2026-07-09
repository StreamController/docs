# Add a Setting

Right now the action always looks the same. Let's give the user a choice: a switch that shows or hides a label on the key.

Settings are built with **Generative UI** rows. You create a row, tell it which setting it controls, and it builds the widget, loads the saved value, and saves changes for you — no manual load/save code.

## Add a switch

Override `get_config_rows` in your action and create a `SwitchRow`:

```python title="SimpleAction.py" hl_lines="1 12-20 24-28"
from GtkHelper.GenerativeUI.SwitchRow import SwitchRow
# ... your existing imports ...

class SimpleAction(ActionCore):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # ... your event assigner ...

    def on_ready(self):
        self.set_media(media_path=self.get_asset_path("info.png"), size=0.75)

        # Show a label only if the setting is on
        if self.get_settings().get("show_label", False):
            self.set_bottom_label("Hello")
        else:
            self.set_bottom_label("")

    def get_config_rows(self):
        self.show_label_switch = SwitchRow(
            action_core=self,
            var_name="show_label",
            default_value=False,
            title="Show label",
            on_change=self.on_show_label_changed
        )
        return self.get_generative_ui_widgets()

    def on_show_label_changed(self, widget, new_value, old_value):
        self.on_ready()  # redraw with the new setting
```

Add the action, open its settings, and toggle the switch — the label appears and disappears, and the choice is remembered when you reopen the settings.

## What just happened

- **`SwitchRow`** is bound to `var_name="show_label"` — a key in this action's settings.
- Toggling it writes `show_label` into your settings **and saves it automatically**.
- **`get_generative_ui_widgets()`** collects every row you created and hands them to StreamController.
- Reading the value anywhere is just `self.get_settings().get("show_label", False)`.
- `on_change` runs after the value is saved — we use it to redraw.

You never wrote load or save code. That's the point of Generative UI.

## The common arguments

Every row type takes the same core arguments (plus a few of its own, like `title`):

| Argument | Meaning |
|---|---|
| `action_core` | The action the row belongs to — pass `self`. |
| `var_name` | The settings key to store the value under. |
| `default_value` | Used when nothing is stored yet, and on reset. |
| `on_change` | `callback(widget, new_value, old_value)` — runs after saving. |
| `can_reset` | Adds a reset button (default `True`). |

## The full menu of rows

`SwitchRow` is one of ten. Import each from `GtkHelper.GenerativeUI.<Name>`:

| Row | Stores | Use it for |
|---|---|---|
| `SwitchRow` | `bool` | An on/off toggle. |
| `EntryRow` | `str` | A text field. |
| `PasswordEntryRow` | `str` | A masked text field (stored encoded). |
| `ComboRow` | item | A dropdown (optional search). |
| `SpinRow` | `float` | A numeric spinner. |
| `ScaleRow` | `float` | A slider. |
| `ToggleRow` | `int` | A segmented set of toggles. |
| `ColorButtonRow` | `(r,g,b,a)` | A colour picker. |
| `FileDialogRow` | `str` | A file picker. |
| `ExpanderRow` | `bool` | A group that holds child rows. |

They all work the same way — swap `SwitchRow` for the one you need. `title`/`subtitle` are automatically [translated](../localization.md) if you pass a locale key.

Next: let's build a second action that remembers a number — the [Counter](../AddCounter.md).

---

!!! info "Need a widget that isn't here?"
    You can also build config rows by hand with GTK/libadwaita — see [Manual config rows](gtk_intro.md). Generative UI covers the common cases with far less code, so reach for the manual approach only when you need something custom.
