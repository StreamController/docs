### 1. Add a new directory
Every action should be located in it's dedicated subdirectory of `actions`.
```shell
mkdir /path_to_plugin/actions/counter
```
This will create a new folder `counter` in the `actions` directory. Feel free to change the name or path as long as it's in the plugin's dir.
### 2. Create a new file for the action
```shell
touch /path_to_plugin/actions/counter/counter.py
```
This creates an empty file `counter.py` in the new folder.
In the next steps we'll add the content to the file.
### 3. Programming the new action
Now let's add the actual action to the `counter.py` file.

```python title="counter.py"
# Import StreamController modules
from src.backend.PluginManager.ActionCore import ActionCore
from src.backend.PluginManager.EventAssigner import EventAssigner
from src.backend.DeckManagement.InputIdentifier import Input

class Counter(ActionCore):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        
        self.add_event_assigner(EventAssigner(
            id="key-down",
            ui_label="Key Down",
            default_event=Input.Key.Events.DOWN,
            callback=self.on_key_down
        ))
```

That's it, at least for now. You just created a basic action without any functionality. However, this would not be shown it the ui yet.

### 4. Register the action
All actions of a plugin have to be registered in the plugin's [plugin base](../bases/PluginBase_py.md), here in [main.py](../plugin_template/main_py.md).  
`main.py` currently looks like this:
```python title="main.py"
# Import StreamController modules
from src.backend.PluginManager.PluginBase import PluginBase
from src.backend.PluginManager.ActionHolder import ActionHolder
from src.backend.PluginManager.ActionInputSupport import ActionInputSupport
from src.backend.DeckManagement.InputIdentifier import Input

# Import actions
from .actions.SimpleAction.SimpleAction import SimpleAction

class PluginTemplate(PluginBase):
    def __init__(self):
        super().__init__()

        ## Register actions
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
        self.add_action_holder(self.simple_action_holder)

        # Register plugin
        self.register(
            plugin_name="Template",
            github_repo="https://github.com/StreamController/PluginTemplate",
            plugin_version="1.0.0",
            app_version="1.5.0-beta.9"
        )
```
The good news is that you just have to add a couple of lines to make your new action available.  
The first step is to import the newly created action. To do so you can just add the following line below the import of `SimpleAction`:
```python
from .actions.counter.counter import Counter
```
The only thing left to do is to register the action by creating an `ActionHolder` and adding it to the plugin:
```python title="main.py" hl_lines="10 28-37"
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

        ## Register actions
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
        self.add_action_holder(self.simple_action_holder)

        self.counter_action_holder = ActionHolder(
            plugin_base=self,
            action_core=Counter,
            action_id_suffix="Counter",
            action_name="Counter",
            action_support={
                Input.Key: ActionInputSupport.SUPPORTED,
                Input.Dial: ActionInputSupport.UNSUPPORTED,
                Input.Touchscreen: ActionInputSupport.UNSUPPORTED
            }
        )
        self.add_action_holder(self.counter_action_holder)

        # Register plugin
        self.register(
            plugin_name="Template",
            github_repo="https://github.com/StreamController/PluginTemplate",
            plugin_version="1.0.0",
            app_version="1.5.0-beta.9"
        )
```
!!! note
    The `action_id_suffix` combined with your plugin ID creates a unique action identifier. You can also use `action_id` for full control over the ID format: `{reverse_domain_with_underscores}::{action_name}`
### 5. Do something!!!
What is the point of an action that does nothing? None at all. But we're going to change that now.  
Let's change the action to count the presses and show the number on the key.  
For that we have to modify `counter.py`:
```python title="counter.py"
# Import StreamController modules
from src.backend.PluginManager.ActionCore import ActionCore
from src.backend.PluginManager.EventAssigner import EventAssigner
from src.backend.DeckManagement.InputIdentifier import Input

class Counter(ActionCore):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        
        self.add_event_assigner(EventAssigner(
            id="key-down",
            ui_label="Key Down",
            default_event=Input.Key.Events.DOWN,
            callback=self.on_key_down
        ))
```
#### 1. The first thing we need to do is to add a counter variable:
```python title="counter.py (partial)" hl_lines="16"
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
```
#### 2. Now we need to increase the counter if the action key gets pressed:
```python title="counter.py (partial)" hl_lines="14-15"
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

    def on_key_down(self):
        self.counter += 1
```
#### 3. Update the label on the key if the counter changes:
```python title="counter.py (partial)" hl_lines="16"
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

    def on_key_down(self):
        self.counter += 1
        self.set_center_label(str(self.counter))
```
#### 4. Show the initial counter on load up:
```python title="counter.py (partial)" hl_lines="14-15"
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
        self.counter += 1
        self.set_center_label(str(self.counter))
```
#### 5. The result
The final `counter.py` looks like this:
```python title="counter.py"
# Import StreamController modules
from src.backend.PluginManager.ActionCore import ActionCore
from src.backend.PluginManager.EventAssigner import EventAssigner
from src.backend.DeckManagement.InputIdentifier import Input

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
        self.counter += 1
        self.set_center_label(str(self.counter))
```
