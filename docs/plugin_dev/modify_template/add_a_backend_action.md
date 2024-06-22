If you need to use many large libraries, you have to add a backend to your action.

## [Rpyc](https://rpyc.readthedocs.io/en/latest/)
The backend of all actions is running in a completely separate [python](https://pypi.org/) process. This means no normal communication between the backend and the actual action is possible. Here comes [rpyc](https://rpyc.readthedocs.io/en/latest/) into play. It creates a communication channel between the action and the backend over the local network. If you want to know more about [rpyc](https://rpyc.readthedocs.io/en/latest/), you can read [it's documentation](https://rpyc.readthedocs.io/en/latest/).

## Add a backend to your action
In this example we'll go over how to add a basic backend to our [CounterAction](AddCounter.md).
!!! info
    In production it would not be necessary to write a backend for such a simple action that does not need any extra libraries, but for the sake of the example we'll add a basic backend anyway.

### 1. Add a new directory
Every action backend should be located in it's dedicated subdirectory of `actions/action_name`.
```shell
mkdir /path_to_plugin/actions/counter/backend
```
This will create a new folder `backend` in the `actions/action_name` directory.

### 2. Create a new file for the backend
```shell
touch /path_to_plugin/actions/counter/backend/backend.py
```
This creates an empty file `backend.py` in the new folder.

### 3. Programming the new backend
Now let's add the actual backend to the `backend.py` file.
```python title="backend.py"
from streamcontroller_plugin_tools import BackendBase #(1)!

class Backend(BackendBase):
    def __init__(self):
        super().__init__()

backend = Backend() #(2)!
```

1. Import the [BackendBase](../bases/BackendBase_py.md)
2. Create an instance of the class

The backend will automatically connect to your action. This is possible because [launch_backend](../bases/ActionBase_py.md#launch_backend) starts `backend.py` with the [rpyc](https://rpyc.readthedocs.io/en/latest/) port as an argument.

### 4. Add counter methods to the backend
Now we can add methods to retrive the current number and increment it.
```python title="backend.py" hl_lines="7-13"
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

### 5. Remove old counter code from [Counter](AddCounter.md)
Now we can remove the old counter code from [Counter](AddCounter.md) because we will use the backend to manage the counter.  
This results into:
```python title="counter.py"
# Import StreamController modules
from src.backend.PluginManager.ActionBase import ActionBase
from src.backend.DeckManagement.DeckController import DeckController
from src.backend.PageManagement.Page import Page
from src.backend.PluginManager.PluginBase import PluginBase

class Counter(ActionBase):
    def __init__(self, action_id: str, action_name: str,
                 deck_controller: DeckController, page: Page, coords: str, plugin_base: PluginBase):
        super().__init__(action_id=action_id, action_name=action_name,
            deck_controller=deck_controller, page=page, coords=coords, plugin_base=plugin_base)

    def on_ready(self):
        pass

    def on_key_down(self):
        pass
```

### 6. Launch the backend from the action
The next step is to launch the backend from the action. To do this, we will use the [launch_backend](../bases/ActionBase_py.md#launch_backend) method of the [ActionBase](../bases/ActionBase_py.md). This method will start the backend with the [rpyc](https://rpyc.readthedocs.io/en/latest/) port of the action as an argument.
```python title="counter.py" hl_lines="7 15-16"
# Import StreamController modules
from src.backend.PluginManager.ActionBase import ActionBase
from src.backend.DeckManagement.DeckController import DeckController
from src.backend.PageManagement.Page import Page
from src.backend.PluginManager.PluginBase import PluginBase

import os

class Counter(ActionBase):
    def __init__(self, action_id: str, action_name: str,
                 deck_controller: DeckController, page: Page, coords: str, plugin_base: PluginBase):
        super().__init__(action_id=action_id, action_name=action_name,
            deck_controller=deck_controller, page=page, coords=coords, plugin_base=plugin_base)

        backend_path = os.path.join(self.plugin_base.PATH, "actions", "counter", "backend", "backend.py") #(1)!
        self.launch_backend(backend_path=backend_path, open_in_terminal=True) #(2)!

    def on_ready(self):
        pass

    def on_key_down(self):
        pass
```

1. Construct the path to the backend
2. Launch the backend

The `open_in_terminal=True` statement will open a new terminal window for the backend. This is useful for debugging, but should not be used in production.

### 7. Test the backend
To test the new backend, we will need to add a [Counter](AddCounter.md) action to the deck.

You should now see a terminal window opening with your backend running.   
If you encounter any problems feel free to open an issue on the [StreamController GitHub repository](https://github.com/StreamController/streamcontroller) and I will try to help you.

### 8. Use the backend
Now that we have a backend, we can use it methods to manage the counter state.
```python title="counter.py" hl_lines="18-23"
# Import StreamController modules
from src.backend.PluginManager.ActionBase import ActionBase
from src.backend.DeckManagement.DeckController import DeckController
from src.backend.PageManagement.Page import Page
from src.backend.PluginManager.PluginBase import PluginBase

import os

class Counter(ActionBase):
    def __init__(self, action_id: str, action_name: str,
                 deck_controller: DeckController, page: Page, coords: str, plugin_base: PluginBase):
        super().__init__(action_id=action_id, action_name=action_name,
            deck_controller=deck_controller, page=page, coords=coords, plugin_base=plugin_base)

        backend_path = os.path.join(self.plugin_base.PATH, "actions", "counter", "backend", "backend.py")
        self.launch_backend(backend_path=backend_path, open_in_terminal=True)

    def on_ready(self):
        self.set_center_label(str(self.backend.get_count()))

    def on_key_down(self):
        self.backend.increase_count()
        self.set_center_label(str(self.backend.get_count()))
```
### 9. Add error handling
With a new component in our plugin than might break or crash, it is always a good idea to inform the user about any errors that might occur. We can do this by using the [show_error](../bases/ActionBase_py.md#show_error) method of the [ActionBase](../bases/ActionBase_py.md).
```python title="counter.py" hl_lines="8 20-27 30-38"
# Import StreamController modules
from src.backend.PluginManager.ActionBase import ActionBase
from src.backend.DeckManagement.DeckController import DeckController
from src.backend.PageManagement.Page import Page
from src.backend.PluginManager.PluginBase import PluginBase

import os
from loguru import logger as log #(1)!

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

1. Import [loguru](https://loguru.readthedocs.io/en/stable/) - the logger of StreamController

This code shows communication errors between the frontend and the backend on the deck.  
If you still have `open_in_terminal` set to `True`, you can easily test the code by closing the terminal window. This will lead to an error on the next key press.
!!! note "Try/Catch"
    If you use try/except to catch such errors, it is important to log the errors in some sort to allow easy debugging.