### 1. Add a new directory
Every action should be located in it's dedicated subdirectory of `actions`.
```shell
mkdir /path/to/plugin/actions/sample_action
```
This will create a new folder `sample_action` in the `actions` directory. Feel free to change the name or path as long as it's in the plugin's dir.
### 2. Create a new file for the action
```shell
touch /path/to/plugin/actions/sample_action/sample_action.py
```
This creates an empty file `sample_action.py` in the new folder.
In the next steps we'll add the content to the file.
### 3. Programming the new action
Now let's add the actual action to the `sample_action.py` file.

```python title="sample_action.py"
from src.backend.PluginManager.ActionBase import ActionBase

class SampleAction(ActionBase):
    ACTION_NAME = "Sample Action"
    def __init__(self, deck_controller, page, coords):
        super().__init__(deck_controller=deck_controller, page=page, coords=coords)
```
That's it, at least for now. You just created a basic sample action without any functionality. However this would not be shown it the ui yet. To see how to achieve this read the next section.

### 4. Register the action
All actions of a plugin have to be registered in the plugin's [plugin base](../bases/PluginBase_py.md), here in [main.py](../plugin_template/main_py.md).  
`main.py` currently looks like this:
```python title="main.py"
from src.backend.PluginManager.ActionBase import ActionBase
from src.backend.PluginManager.PluginBase import PluginBase

# Import gtk modules
import gi
gi.require_version("Gtk", "4.0")
gi.require_version("Adw", "1")
from gi.repository import Gtk, Adw

# Import actions
from .actions.Backend.BackendAction import BackendAction

class PluginTemplate(PluginBase):
    def __init__(self):
        self.PLUGIN_NAME = "PluginTemplate"
        self.GITHUB_REPO = "https://github.com/Core447/PluginTemplate"
        super().__init__()

        self.add_action(BackendAction)
```
The good news is that you just have to add two lines to make your new action available.  
The first step is to import the newly created action. To do so you can just add the following line below the import of `BackendAction`:
```python
from .actions.sample_action.sample_action import SampleAction
```
The only thing left to do is to add the action to the plugin by adding this line below `self.add_action(BackendAction)`:
```python
self.add_action(SampleAction)
```
### 5. Do something!!!
What is the point of an action that does nothing? None at all. But we're going to change that now.  
Let's change the action to cound the presses and shows the number on the key.  
For that we have to modify the `sample_action.py`:
```python title="sample_action.py"
from src.backend.PluginManager.ActionBase import ActionBase

class SampleAction(ActionBase):
    ACTION_NAME = "Sample Action"
    def __init__(self, deck_controller, page, coords):
        super().__init__(deck_controller=deck_controller, page=page, coords=coords)
```
1. The first thing wee need to do is to add a counter variable to our `SampleAction` class:
```python title="sample_action.py" hl_lines="6"
from src.backend.PluginManager.ActionBase import ActionBase

class SampleAction(ActionBase):
    ACTION_NAME = "Sample Action"
    def __init__(self, deck_controller, page, coords):
        self.counter: int = 0
        super().__init__(deck_controller=deck_controller, page=page, coords=coords)
```
2. Now we need to increase the counter if the action key gets pressed:
```python title="sample_action.py" hl_lines="9 10"
from src.backend.PluginManager.ActionBase import ActionBase

class SampleAction(ActionBase):
    ACTION_NAME = "Sample Action"
    def __init__(self, deck_controller, page, coords):
        self.counter: int = 0
        super().__init__(deck_controller=deck_controller, page=page, coords=coords)
    
    def on_key_down(self):
        self.counter += 1
```
3. Update the label on the key if the counter changes:
```python title="sample_action.py"  hl_lines="11"
from src.backend.PluginManager.ActionBase import ActionBase

class SampleAction(ActionBase):
    ACTION_NAME = "Sample Action"
    def __init__(self, deck_controller, page, coords):
        self.counter: int = 0
        super().__init__(deck_controller=deck_controller, page=page, coords=coords)
    
    def on_key_down(self):
        self.counter += 1
        self.set_center_label(str(self.counter))
```
4. Show the initial counter on load up:
```python title="sample_action.py"  hl_lines="9 10"
from src.backend.PluginManager.ActionBase import ActionBase

class SampleAction(ActionBase):
    ACTION_NAME = "Sample Action"
    def __init__(self, deck_controller, page, coords):
        self.counter: int = 0
        super().__init__(deck_controller=deck_controller, page=page, coords=coords)

    def on_ready(self):
        self.set_center_label(str(self.counter))
    
    def on_key_down(self):
        self.counter += 1
        self.set_center_label(str(self.counter))
```