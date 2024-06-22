The [Adw.SpinRow](https://gnome.pages.gitlab.gnome.org/libadwaita/doc/1-latest/class.SpinRow.html) added in [Add Config Rows](config/add_config_rows.md) has an English title and subtitle. This is fine for English users, but for other languages the title and subtitle are not localized. This is why plugins should use StreamControllers [LocaleManager](https://github.com/StreamController/StreamController/blob/main/locales/LocaleManager.py).

[LocaleManager](https://github.com/StreamController/StreamController/blob/main/locales/LocaleManager.py) chooses the right localized string based on the language the user is using.

The [LocaleManager](https://github.com/StreamController/StreamController/blob/main/locales/LocaleManager.py) of your plugin can be reached with `self.locale_manager` in the [`PluginBase`](../bases/PluginBase_py.md) and with `self.plugin_base.locale_manager` in your [`Actions`](../bases/ActionBase_py.md).

!!! info
    Each plugin must be available in English.

## 1. How to localize
- Locals are placed in the `locales` subfolder of your plugin (you might have to create it if it doesn't exist) and in the format of `json` files.
- The json cannot contain keys containing a new dictionary.  
This is valid:
```json
{
    "plugin.name": "Name"
}
```
This isn't:
```json
{
    "plugin": {
        "name": "Name"
    }
}
```
- The values can be retrieved with `self.locale_manager.get("key")`

## 2. Localize the plugin
In this example we will localize the [counter action](AddCounter.md) in [this](config/add_config_rows.md#7-use-the-value) state.
### 2.1 Localize the [PluginBase](../bases/PluginBase_py.md)
#### Add a language file
Create a new `locales` subfolder in your plugin by typing:
```bash
mkdir locales
```
Add a new `en_US.json` file to the `locales` subfolder by typing:
```bash
touch locales/en_US.json
```
Add the needed language keys:
```json
{
    "plugin.name": "Template",
    "actions.simple.name": "Simple Action",
    "actions.counter.name": "Counter",
}
```

#### Use the language file
```python title="main.py" hl_lines="13 20 28 34"
# Import StreamController modules
from src.backend.PluginManager.PluginBase import PluginBase
from src.backend.PluginManager.ActionHolder import ActionHolder

# Import actions
from .actions.SimpleAction.SimpleAction import SimpleAction
from .actions.counter.counter import Counter

class PluginTemplate(PluginBase):
    def __init__(self):
        super().__init__()

        self.lm = self.locale_manager #(1)!

        ## Register actions
        self.simple_action_holder = ActionHolder(
            plugin_base = self,
            action_base = SimpleAction,
            action_id = "dev_core447_Template::SimpleAction", # Change this to your own plugin id
            action_name = self.lm.get("actions.simple.name")
        )
        self.add_action_holder(self.simple_action_holder)

        self.counter_action_holder = ActionHolder(
            plugin_base = self,
            action_base = Counter,
            action_id = "dev_core447_Template::Counter", # Change this to your own plugin id
            action_name = self.lm.get("actions.counter.name")
        )
        self.add_action_holder(self.counter_action_holder)

        # Register plugin
        self.register(
            plugin_name = self.lm.get("plugin.name"),
            github_repo = "https://github.com/StreamController/PluginTemplate",
            plugin_version = "1.0.0",
            app_version = "1.1.1-alpha"
        )
```

1. Make the [LocaleManager](https://github.com/StreamController/StreamController/blob/main/locales/LocaleManager.py) available under a shorter name

!!! warning
    Do **not** localize the `action_ids`. This will result in disabled action if the user switches to another language.  
    Only localize visible strings.

## 2.2 Localize the [counter](AddCounter.md)
Extend `en_US.json` by the following keys:
```json
{
    "actions.counter.spinner.title": "Increment by",
    "actions.counter.spinner.subtitle": "How much to increment the counter by"
}
```
Now we have to modify `counter.py` in order to use the new keys:
```python title="counter.py" hl_lines="31-32"
# Import StreamController modules
from src.backend.PluginManager.ActionBase import ActionBase
from src.backend.DeckManagement.DeckController import DeckController
from src.backend.PageManagement.Page import Page
from src.backend.PluginManager.PluginBase import PluginBase

# Import gtk
import gi
gi.require_version("Gtk", "4.0")
gi.require_version("Adw", "1")
from gi.repository import Gtk, Adw

class Counter(ActionBase):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

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