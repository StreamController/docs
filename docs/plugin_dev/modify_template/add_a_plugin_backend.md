The [last section](add_a_backend_action.md) was all about adding a backend to an individual action, whereas in reality if often makes more sense to have one backend for the entire plugin. The [OBS plugin](https://github.com/StreamController/OBSPlugin) is an example of this.

To learn more about how the communication works, check out the [last section](add_a_backend_action.md).

## Add a backend to our plugin
In this example we'll go over how to add a basic backend to our plugin, by moving the action backend of the [last section](add_a_backend_action.md) to the plugin itself.

### 1. Add a new directory
The backend should be seperated from the rest of the plugin.
```shell
mkdir /path_to_plugin/backend
```
This will create a new folder `backend` in the `plugin` directory.

### 2. Create a new file for the backend
```shell
touch /path_to_plugin/backend/backend.py
```
This creates an empty file `backend.py` in the new folder.

### 3. Programming the backend
Now let's add the actual backend to the `backend.py` file.  We'll use the same as in the [action backend](add_a_backend_action.md#3-programming-the-new-backend).
```python title="backend.py"
from streamcontroller_plugin_tools import BackendBase

class Backend(BackendBase):
    def __init__(self):
        super().__init__()

        self.counter: int = 0

    def get_count(self) -> int:
        return self.counter

    def increase_count(self) -> None:
        self.counter += 1

backend = Backend()
```
!!! note
    As you can see there is no difference in the backend code between a plugin and an action backend.

### 4. Remove [backend launch](../bases/ActionBase_py.md#launch_backend) from the [counter action](AddCounter.md)
To do this remove the highlighted lines:
```python title="counter.py" hl_lines="16-17"
# Import StreamController modules
from src.backend.PluginManager.ActionBase import ActionBase
from src.backend.DeckManagement.DeckController import DeckController
from src.backend.PageManagement.Page import Page
from src.backend.PluginManager.PluginBase import PluginBase

import os
from loguru import logger as log 

class Counter(ActionBase):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        backend_path = os.path.join(self.plugin_base.PATH, "actions", "counter", "backend", "backend.py")
        self.launch_backend(backend_path=backend_path, open_in_terminal=True)

    def on_ready(self):
        try:
            count = str(self.backend.get_count())
        except Exception as e:
            log.error(e)
            self.show_error()
            return

        self.set_center_label(count)

    def on_key_down(self):
        try:
            self.backend.increase_count()
            count = str(self.backend.get_count())
        except Exception as e:
            log.error(e)
            self.show_error()
            return

        self.set_center_label(count)
```

### 5. Launch the backend
Now we can launch the backend from within the plugin:
```python title="main.py" hl_lines="13-15"
# Import StreamController modules
from src.backend.PluginManager.PluginBase import PluginBase
from src.backend.PluginManager.ActionHolder import ActionHolder

# Import actions
from .actions.SimpleAction.SimpleAction import SimpleAction
from .actions.counter.counter import Counter

class PluginTemplate(PluginBase):
    def __init__(self):
        super().__init__()

        ## Launch backend
        backend_path = os.path.join(self.PATH, "backend", "backend.py") 
        self.launch_backend(backend_path=backend_path, open_in_terminal=True) 

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

### 6. Use the backend
Now we can modify `counter.py` to use the new plugin backend:
```python title="counter.py" hl_lines="18 28-29"
# Import StreamController modules
from src.backend.PluginManager.ActionBase import ActionBase
from src.backend.DeckManagement.DeckController import DeckController
from src.backend.PageManagement.Page import Page
from src.backend.PluginManager.PluginBase import PluginBase

import os
from loguru import logger as log 

class Counter(ActionBase):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

    def on_ready(self):
        try:
            count = str(self.plugin_base.backend.get_count())
        except Exception as e:
            log.error(e)
            self.show_error()
            return

        self.set_center_label(count)

    def on_key_down(self):
        try:
            self.plugin_base.backend.increase_count()
            count = str(self.plugin_base.backend.get_count())
        except Exception as e:
            log.error(e)
            self.show_error()
            return

        self.set_center_label(count)
```