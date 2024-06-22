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
from src.backend.PluginManager.ActionBase import ActionBase
from src.backend.DeckManagement.DeckController import DeckController
from src.backend.PageManagement.Page import Page
from src.backend.PluginManager.PluginBase import PluginBase

class Counter(ActionBase):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
```

That's it, at least for now. You just created a basic action without any functionality. However, this would not be shown it the ui yet.

### 4. Register the action
All actions of a plugin have to be registered in the plugin's [plugin base](../bases/PluginBase_py.md), here in [main.py](../plugin_template/main_py.md).  
`main.py` currently looks like this:
```python title="main.py"
# Import StreamController modules
from src.backend.PluginManager.PluginBase import PluginBase
from src.backend.PluginManager.ActionHolder import ActionHolder

# Import actions
from .actions.SimpleAction.SimpleAction import SimpleAction

class PluginTemplate(PluginBase):
    def __init__(self):
        super().__init__()

        ## Register actions
        self.simple_action_holder = ActionHolder(
            plugin_base = self,
            action_base = SimpleAction,
            action_id = "dev_core447_Template::SimpleAction", # Change this to your own plugin id
            action_name = "Simple Action",
        )
        self.add_action_holder(self.simple_action_holder)

        # Register plugin
        self.register(
            plugin_name = "Template",
            github_repo = "https://github.com/StreamController/PluginTemplate",
            plugin_version = "1.0.0",
            app_version = "1.1.1-alpha"
        )
```
The good news is that you just have to add a couple of lines to make your new action available.  
The first step is to import the newly created action. To do so you can just add the following line below the import of `SimpleAction`:
```python
from .actions.counter.counter import Counter
```
The only thing left to do is to register the action by creating an [ActionHolder]() and adding it to the plugin:
```python title="main.py" hl_lines="22-28"
# Import StreamController modules
from src.backend.PluginManager.PluginBase import PluginBase
from src.backend.PluginManager.ActionHolder import ActionHolder

# Import actions
from .actions.SimpleAction.SimpleAction import SimpleAction
from .actions.counter.counter import Counter

class PluginTemplate(PluginBase):
    def __init__(self):
        super().__init__()

        ## Register actions
        self.simple_action_holder = ActionHolder(
            plugin_base = self,
            action_base = SimpleAction,
            action_id = "dev_core447_Template::SimpleAction", # Change this to your own plugin id
            action_name = "Simple Action",
        )
        self.add_action_holder(self.simple_action_holder)

        self.counter_action_holder = ActionHolder(
            plugin_base = self,
            action_base = Counter,
            action_id = "dev_core447_Template::Counter", # Change this to your own plugin id
            action_name = "Counter",
        )
        self.add_action_holder(self.counter_action_holder)

        # Register plugin
        self.register(
            plugin_name = "Template",
            github_repo = "https://github.com/StreamController/PluginTemplate",
            plugin_version = "1.0.0",
            app_version = "1.1.1-alpha"
        )
```
!!! note
    The `action_id` must be unique and in the following format: {reverse-domain with underscores}::{action_name}
### 5. Do something!!!
What is the point of an action that does nothing? None at all. But we're going to change that now.  
Let's change the action to cound the presses and show the number on the key.  
For that we have to modify `counter.py`:
```python title="counter.py"
# Import StreamController modules
from src.backend.PluginManager.ActionBase import ActionBase
from src.backend.DeckManagement.DeckController import DeckController
from src.backend.PageManagement.Page import Page
from src.backend.PluginManager.PluginBase import PluginBase

class Counter(ActionBase):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
```
#### 1. The first thing we need to do is to add a counter variable:
```python title="counter.py (partial)" hl_lines="7"
class Counter(ActionBase):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.counter: int = 0
```
#### 2. Now we need to increase the counter if the action key gets pressed:
```python title="counter.py (partial)" hl_lines="9 10"
class Counter(ActionBase):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.counter: int = 0

    def on_key_down(self):
        self.counter += 1
```
#### 3. Update the label on the key if the counter changes:
```python title="counter.py (partial)"  hl_lines="11"
class Counter(ActionBase):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.counter: int = 0

    def on_key_down(self):
        self.counter += 1
        self.set_center_label(str(self.counter))
```
#### 4. Show the initial counter on load up:
```python title="counter.py (partial)"  hl_lines="9-10"
class Counter(ActionBase):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

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
from src.backend.PluginManager.ActionBase import ActionBase
from src.backend.DeckManagement.DeckController import DeckController
from src.backend.PageManagement.Page import Page
from src.backend.PluginManager.PluginBase import PluginBase

class Counter(ActionBase):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.counter: int = 0

    def on_ready(self):
        self.set_center_label(str(self.counter))

    def on_key_down(self):
        self.counter += 1
        self.set_center_label(str(self.counter))
```