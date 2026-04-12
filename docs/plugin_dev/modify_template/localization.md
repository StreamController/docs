The [Adw.SpinRow](https://gnome.pages.gitlab.gnome.org/libadwaita/doc/1-latest/class.SpinRow.html) added in [Add Config Rows](config/add_config_rows.md) has an English title and subtitle. This is fine for English users, but for other languages the title and subtitle are not localized. This is why plugins should use StreamController's LocaleManager.

The LocaleManager chooses the right localized string based on the language the user is using.

The LocaleManager of your plugin can be reached with `self.locale_manager` in the [`PluginBase`](../bases/PluginBase_py.md) and with `self.plugin_base.locale_manager` in your actions.

!!! info
    Each plugin must be available in English.

## Localization Formats

StreamController supports two localization formats:

### CSV Format (Recommended)

The modern approach uses a single `locales.csv` file:

```csv title="locales.csv"
key;en_US;de_DE;fr_FR
plugin.name;My Plugin;Mein Plugin;Mon Plugin
actions.counter.name;Counter;Zähler;Compteur
actions.counter.spinner.title;Increment by;Erhöhen um;Incrémenter de
```

To use CSV localization, initialize your plugin with:
```python
class MyPlugin(PluginBase):
    def __init__(self):
        super().__init__()
        self.lm = self.locale_manager
        self.lm.set_to_os_default()
```

### JSON Format (Legacy)

The older approach uses separate JSON files for each language in a `locales` folder:

```
locales/
├── en_US.json
├── de_DE.json
└── fr_FR.json
```

```json title="en_US.json"
{
    "plugin.name": "My Plugin",
    "actions.counter.name": "Counter"
}
```

!!! note
    JSON locales cannot contain nested dictionaries. Use flat key names like `"actions.counter.name"` instead of nested objects.

## How to Localize

### 1. Create the locale file

For CSV format, create `locales.csv` in your plugin root:
```csv
key;en_US
plugin.name;Template
actions.simple.name;Simple Action
actions.counter.name;Counter
actions.counter.spinner.title;Increment by
actions.counter.spinner.subtitle;How much to increment the counter by
```

### 2. Use locale strings in PluginBase

```python title="main.py" hl_lines="14 22 32"
# Import StreamController modules
from src.backend.PluginManager.PluginBase import PluginBase
from src.backend.PluginManager.ActionHolder import ActionHolder
from src.backend.PluginManager.ActionInputSupport import ActionInputSupport
from src.backend.DeckManagement.InputIdentifier import Input

# Import actions
from .actions.SimpleAction.SimpleAction import SimpleAction
from .actions.counter.counter import Counter

class PluginTemplate(PluginBase):
    def __init__(self):
        super().__init__()

        self.lm = self.locale_manager #(1)!
        self.lm.set_to_os_default()

        ## Register actions
        self.simple_action_holder = ActionHolder(
            plugin_base=self,
            action_core=SimpleAction,
            action_id_suffix="SimpleAction",
            action_name=self.lm.get("actions.simple.name"),
            action_support={
                Input.Key: ActionInputSupport.SUPPORTED,
                Input.Dial: ActionInputSupport.UNSUPPORTED,
                Input.Touchscreen: ActionInputSupport.UNSUPPORTED
            }
        )
        self.add_action_holder(self.simple_action_holder)

        self.counter_action_holder = ActionHolder(
            plugin_base=self,
            action_core=Counter,
            action_id_suffix="Counter",
            action_name=self.lm.get("actions.counter.name"),
            action_support={
                Input.Key: ActionInputSupport.SUPPORTED,
                Input.Dial: ActionInputSupport.UNSUPPORTED,
                Input.Touchscreen: ActionInputSupport.UNSUPPORTED
            }
        )
        self.add_action_holder(self.counter_action_holder)

        # Register plugin
        self.register(
            plugin_name=self.lm.get("plugin.name"),
            github_repo="https://github.com/StreamController/PluginTemplate",
            plugin_version="1.0.0",
            app_version="1.5.0-beta.9"
        )
```

1. Make the LocaleManager available under a shorter name

!!! warning
    Do **not** localize the `action_id` or `action_id_suffix`. This will result in disabled actions if the user switches to another language.  
    Only localize visible strings.

### 3. Use locale strings in Actions

```python title="counter.py" hl_lines="27-28"
# Import StreamController modules
from src.backend.PluginManager.ActionCore import ActionCore
from src.backend.PluginManager.EventAssigner import EventAssigner
from src.backend.DeckManagement.InputIdentifier import Input

# Import gtk
import gi
gi.require_version("Gtk", "4.0")
gi.require_version("Adw", "1")
from gi.repository import Gtk, Adw

class Counter(ActionCore):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        
        self.add_event_assigner(EventAssigner(
            id="key-down",
            ui_label="Key Down",
            default_event=Input.Key.Events.DOWN,
            callback=self.on_key_down
        ))
        
        self.counter: int = 0

    def get_config_rows(self) -> list:
        self.spinner = Adw.SpinRow.new_with_range(1, 100, 1)
        self.spinner.set_title(self.plugin_base.lm.get("actions.counter.spinner.title"))
        self.spinner.set_subtitle(self.plugin_base.lm.get("actions.counter.spinner.subtitle"))

        self.load_config_values()
        self.spinner.connect("changed", self.on_spinner_value_changed)

        return [self.spinner]

    # ... rest of the action code
```

### 4. Using GenerativeUI with Localization

[GenerativeUI](../bases/GenerativeUI.md) widgets automatically look up translations for their titles:

```python
from GtkHelper.GenerativeUI.SpinRow import SpinRow

self.increment_row = SpinRow(
    action_core=self,
    var_name="increment_by",
    default_value=1,
    title="actions.counter.spinner.title",  # Translation key
    min=1, max=100, step=1
)
```

The widget will call `get_translation("actions.counter.spinner.title")` automatically.

## Adding More Languages

### CSV Format

Simply add more columns:

```csv
key;en_US;de_DE;fr_FR;es_ES
plugin.name;My Plugin;Mein Plugin;Mon Plugin;Mi Plugin
```

### JSON Format

Create additional JSON files:

```json title="de_DE.json"
{
    "plugin.name": "Mein Plugin",
    "actions.counter.name": "Zähler"
}
```

## Complete Example

```python title="counter.py"
# Import StreamController modules
from src.backend.PluginManager.ActionCore import ActionCore
from src.backend.PluginManager.EventAssigner import EventAssigner
from src.backend.DeckManagement.InputIdentifier import Input

# Import gtk
import gi
gi.require_version("Gtk", "4.0")
gi.require_version("Adw", "1")
from gi.repository import Gtk, Adw

class Counter(ActionCore):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        
        self.add_event_assigner(EventAssigner(
            id="key-down",
            ui_label="Key Down",
            default_event=Input.Key.Events.DOWN,
            callback=self.on_key_down
        ))

        self.counter: int = 0

    def on_ready(self):
        self.set_center_label(str(self.counter))

    def on_key_down(self):
        settings = self.get_settings()
        self.counter += settings.get("increment_by", 1)
        self.set_center_label(str(self.counter))

    def get_config_rows(self) -> list:
        self.spinner = Adw.SpinRow.new_with_range(1, 100, 1)
        self.spinner.set_title(self.plugin_base.lm.get("actions.counter.spinner.title"))
        self.spinner.set_subtitle(self.plugin_base.lm.get("actions.counter.spinner.subtitle"))

        self.load_config_values()

        self.spinner.connect("changed", self.on_spinner_value_changed)

        return [self.spinner]

    def load_config_values(self):
        settings = self.get_settings()
        self.spinner.set_value(settings.get("increment_by", 1))

    def on_spinner_value_changed(self, spinner):
        settings = self.get_settings()
        settings["increment_by"] = int(spinner.get_value())
        self.set_settings(settings)
```
