# Register Your Action

You wrote an action, but how does StreamController know it exists? That's the job of **`main.py`**, your plugin's entry point. Every action gets **registered** here so it shows up in the action picker.

Here's the template's `main.py`:

```python title="main.py"
from src.backend.PluginManager.PluginBase import PluginBase
from src.backend.PluginManager.ActionHolder import ActionHolder
from src.backend.PluginManager.ActionInputSupport import ActionInputSupport
from src.backend.DeckManagement.InputIdentifier import Input

from .actions.SimpleAction.SimpleAction import SimpleAction


class PluginTemplate(PluginBase):
    def __init__(self):
        super().__init__()

        self.simple_action_holder = ActionHolder(
            plugin_base = self,
            action_core = SimpleAction,
            action_id_suffix = "SimpleAction",
            action_name = "Simple Action",
            action_support = {
                Input.Key: ActionInputSupport.SUPPORTED,
                Input.Dial: ActionInputSupport.SUPPORTED,
                Input.Touchscreen: ActionInputSupport.UNSUPPORTED,
            }
        )
        self.add_action_holder(self.simple_action_holder)

        self.register(
            plugin_name = "Template",
            github_repo = "https://github.com/StreamController/PluginTemplate",
            plugin_version = "1.0.0",
            app_version = "1.5.0-beta.14"
        )
```

Let's read it top to bottom.

## Your plugin is a class

```python
class PluginTemplate(PluginBase):
    def __init__(self):
        super().__init__()
```

Your plugin extends **`PluginBase`**. Everything happens in `__init__`: you describe your actions, then register the plugin.

## Wrap each action in an `ActionHolder`

```python
self.simple_action_holder = ActionHolder(
    plugin_base = self,
    action_core = SimpleAction,
    action_id_suffix = "SimpleAction",
    action_name = "Simple Action",
    action_support = { ... }
)
self.add_action_holder(self.simple_action_holder)
```

An **`ActionHolder`** is a little description of your action that the app can read *before* it actually creates the action:

- `action_core`: your action class.
- `action_name`: the label shown in the action picker.
- `action_id_suffix`: combined with your plugin id into a unique id (`<plugin_id>::SimpleAction`).
- `action_support`: which input types your action works on. Here it's usable on keys and dials, but not the touchscreen.

`add_action_holder(...)` hands it to the plugin. For a second action, you'd create a second holder and add it too, exactly what we'll do in the [Counter step](../modify_template/AddCounter.md).

## Register the plugin

```python
self.register(
    plugin_name = "Template",
    github_repo = "https://github.com/StreamController/PluginTemplate",
    plugin_version = "1.0.0",
    app_version = "1.5.0-beta.14"
)
```

The final `register(...)` call switches your plugin on. Fill in your own name, repository and version here (we'll polish these in [Prepare to Publish](manifest_json.md)).

Next: let's make the action actually *do* something when pressed, [React to Input](../modify_template/input_events.md).
