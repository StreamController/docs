The [main.py](main_py.md) is the main file of your plugin and will be executed when the plugin is loaded.
Therefore this is the place where you can add your actions to your plugin.


Per default the file looks like this:  
```python title="main.py"
# Import StreamController modules
from src.backend.PluginManager.PluginBase import PluginBase #(1)!
from src.backend.PluginManager.ActionHolder import ActionHolder #(2)!

# Import actions
from .actions.SimpleAction.SimpleAction import SimpleAction #(3)!

class PluginTemplate(PluginBase):
    def __init__(self):
        super().__init__()

        ## Register actions
        self.simple_action_holder = ActionHolder( #(4)!
            plugin_base = self,
            action_base = SimpleAction,
            action_id = "dev_core447_Template::SimpleAction", # Change this to your own plugin id
            action_name = "Simple Action",
        )
        self.add_action_holder(self.simple_action_holder) #(5)!

        # Register plugin
        self.register(
            plugin_name = "Template",
            github_repo = "https://github.com/StreamController/PluginTemplate",
            plugin_version = "1.0.0",
            app_version = "1.1.1-alpha"
        ) #(5)!
```

1. Import the [PluginBase](../bases/PluginBase_py.md) class which is the base for all plugins.
2. Import the `ActionHolder` class which holds [ActionBases] until creation.
3. Import the [SimpleAction]() which is a sample action with no backend.
4. Create a new [ActionHolder]() class for the [SimpleAction] action.
5. Add the [ActionHolder]() to the plugin.
6. Register the plugin.


## Let's go over the code:

### Import StreamController modules
```python
from src.backend.PluginManager.PluginBase import PluginBase
```
imports the [PluginBase]() which is the base class for all plugins.

```python
from src.backend.PluginManager.ActionHolder import ActionHolder
```
imports the [ActionHolder]() which holds [ActionBases] until creation.

### Import actions
```python
from .actions.SimpleAction.SimpleAction import SimpleAction
```
imports the [SimpleAction](SimpleAction_py.md).
This is the sample action with no backend.

### The plugin class
```python
self.simple_action_holder = ActionHolder(
            plugin_base = self,
            action_base = SimpleAction,
            action_id = "dev_core447_Template::SimpleAction", # Change this to your own plugin id
            action_name = "Simple Action",
        )
```
creates an [ActionHolder]() for the [SimpleAction] action.

```python
self.add_action_holder(self.simple_action_holder)
```
adds the [ActionHolder]() to the plugin.

```python
self.register(
            plugin_name = "Template",
            github_repo = "https://github.com/StreamController/PluginTemplate",
            plugin_version = "1.0.0",
            app_version = "1.1.1-alpha"
        )
```
registers the plugin. See [register](../bases/PluginBase_py.md#register).