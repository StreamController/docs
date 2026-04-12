The [main.py](main_py.md) is the main file of your plugin and will be executed when the plugin is loaded.
Therefore this is the place where you register your actions with the plugin.


Per default the file looks like this:  
```python title="main.py"
# Import StreamController modules
from src.backend.PluginManager.PluginBase import PluginBase #(1)!
from src.backend.PluginManager.ActionHolder import ActionHolder #(2)!
from src.backend.PluginManager.ActionInputSupport import ActionInputSupport #(3)!
from src.backend.DeckManagement.InputIdentifier import Input #(4)!

# Import actions
from .actions.SimpleAction.SimpleAction import SimpleAction #(5)!

class PluginTemplate(PluginBase):
    def __init__(self):
        super().__init__()

        ## Register actions
        self.simple_action_holder = ActionHolder( #(6)!
            plugin_base=self,
            action_core=SimpleAction,
            action_id_suffix="SimpleAction",  # Results in: com_example_Template::SimpleAction
            action_name="Simple Action",
            action_support={  #(7)!
                Input.Key: ActionInputSupport.SUPPORTED,
                Input.Dial: ActionInputSupport.UNSUPPORTED,
                Input.Touchscreen: ActionInputSupport.UNSUPPORTED
            }
        )
        self.add_action_holder(self.simple_action_holder) #(8)!

        # Register plugin
        self.register(
            plugin_name="Template",
            github_repo="https://github.com/StreamController/PluginTemplate",
            plugin_version="1.0.0",
            app_version="1.5.0-beta.9"
        ) #(9)!
```

1. Import the [PluginBase](../bases/PluginBase_py.md) class which is the base for all plugins.
2. Import the `ActionHolder` class which holds action metadata until instantiation.
3. Import `ActionInputSupport` to declare which input types your action supports.
4. Import `Input` for input type constants.
5. Import the [SimpleAction](SimpleAction_py.md) which is a sample action.
6. Create a new `ActionHolder` for the SimpleAction.
7. Declare which input types this action supports.
8. Add the `ActionHolder` to the plugin.
9. Register the plugin.


## Let's go over the code:

### Import StreamController modules
```python
from src.backend.PluginManager.PluginBase import PluginBase
```
imports the [PluginBase](../bases/PluginBase_py.md) which is the base class for all plugins.

```python
from src.backend.PluginManager.ActionHolder import ActionHolder
```
imports the `ActionHolder` which holds action classes and their metadata until they need to be instantiated.

```python
from src.backend.PluginManager.ActionInputSupport import ActionInputSupport
from src.backend.DeckManagement.InputIdentifier import Input
```
imports the types needed to declare input support for your actions.

### Import actions
```python
from .actions.SimpleAction.SimpleAction import SimpleAction
```
imports the [SimpleAction](SimpleAction_py.md).

### The plugin class
```python
self.simple_action_holder = ActionHolder(
    plugin_base=self,
    action_core=SimpleAction,
    action_id_suffix="SimpleAction",
    action_name="Simple Action",
    action_support={
        Input.Key: ActionInputSupport.SUPPORTED,
        Input.Dial: ActionInputSupport.UNSUPPORTED,
        Input.Touchscreen: ActionInputSupport.UNSUPPORTED
    }
)
```
creates an `ActionHolder` for the SimpleAction.

| Parameter | Description |
|-----------|-------------|
| `plugin_base` | Reference to your plugin |
| `action_core` | The action class (extends [ActionCore](../bases/ActionCore_py.md)) |
| `action_id_suffix` | Unique suffix for the action ID (combined with plugin ID) |
| `action_name` | Human-readable name shown in the UI |
| `action_support` | Dict declaring which input types are supported |

!!! tip
    You can also use `action_id` instead of `action_id_suffix` if you want full control over the action ID. The format should be: `{reverse_domain_with_underscores}::{action_name}`

### Input Support

The `action_support` dict tells StreamController which input types your action works with:

| Value | Meaning |
|-------|---------|
| `ActionInputSupport.SUPPORTED` | Fully tested and working |
| `ActionInputSupport.UNTESTED` | May work, not tested (default if omitted) |
| `ActionInputSupport.UNSUPPORTED` | Does not work with this input type |

```python
self.add_action_holder(self.simple_action_holder)
```
adds the `ActionHolder` to the plugin, making the action available in the UI.

### Plugin Registration
```python
self.register(
    plugin_name="Template",
    github_repo="https://github.com/StreamController/PluginTemplate",
    plugin_version="1.0.0",
    app_version="1.5.0-beta.9"
)
```
registers the plugin with StreamController. See [register](../bases/PluginBase_py.md#register).

| Parameter | Description |
|-----------|-------------|
| `plugin_name` | Display name (can be localized) |
| `github_repo` | Link to your repository |
| `plugin_version` | Your plugin's version |
| `app_version` | Minimum StreamController version required |
