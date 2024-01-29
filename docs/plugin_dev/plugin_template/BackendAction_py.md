```python title="BackendAction.py"
from src.backend.PluginManager.ActionBase import ActionBase

import os
import Pyro5.api

@Pyro5.api.expose
class BackendAction(ActionBase):
    ACTION_NAME = "Backend Action"
    def __init__(self, deck_controller, page, coords):
        super().__init__(deck_controller=deck_controller, page=page, coords=coords)

        # Launch backend (optional)
        backend_path = os.path.join(os.path.dirname(__file__), "backend.py")
        self.launch_backend(backend_path=backend_path)

    def on_key_down(self):
        self.set_bottom_label(self.backend.get_number())
```

As the name implies, this is an action with a backend, a dedicated backend to be exact.
Such a backend is not always necessary, but required if you want to use third party [python modules](https://pypi.org/).

If you want to have a look at how to add an action without backend, head over [here](../modify_template/add_simple_action.md).

## [Pyro5](https://pyro5.readthedocs.io/en/latest/)
The backend of all actions is running in a completely separate [python](https://pypi.org/) process. This means no normal communication between the backend and the actual action is possible. Here comes [Pyro5](https://pyro5.readthedocs.io/en/latest/) into play. It creates a communication channel between the action and the backend over the local network. If you want to know more about Pyro5, you can read [it's documentation](https://pyro5.readthedocs.io/en/latest/).
!!! variables
    Due to safety reasons [Pyro5](https://pyro5.readthedocs.io/en/latest/) disallows the direct access of variables of the backend from the frontend and vice versa. For this reason you have to use [getters and setters](https://medium.com/@pijpijani/understanding-property-in-python-getters-and-setters-b65b0eee62f9).

## Let's go over the code:

### StreamController imports
```python
from src.backend.PluginManager.ActionBase import ActionBase
```
imports the [ActionBase]() which is the base class for all actions.

### General imports
```python
import os
import Pyro5.api
```
imports `os` to generate the path of the [backend](backend_py.md) and `Pyro5` to create the communication channel.

### Action name
```python
ACTION_NAME = "Backend Action"
```
This is the name of your action and will be shown in the ui.

### Init the action
```python
def __init__(self, deck_controller, page, coords):
    super().__init__(deck_controller=deck_controller, page=page, coords=coords)
```
This is the init function of your action.  
The arguments will be provided by the [PluginManager](https://github.com/Core447/StreamController/blob/main/src/backend/PluginManager/PluginManager.py) of [StreamController](https://github.com/Core447/StreamController) on initialization of the action.

### Backend launch
```python
backend_path = os.path.join(os.path.dirname(__file__), "backend.py")
```
This gets the path of the [backend](backend_py.md) file.
```python
self.launch_backend(backend_path=backend_path)
```
This launches the backend and establishes a connection with the backend.  
The backend will be loaded in a new python process.
!!! Modules
    If you want to use third party modules you'll need to run the [backend](backend_py.md) in a custom environment. You can do so by providing `venv_activate_path` to the method. Usually this is `.venv/bin/activate`.  
    Head over to [\_\_install\_\_.py](__install___py.md) to learn how to create a custom environment on plugin installation.

### on_key_down
```python
def on_key_down(self):
```
This function is executed when the action key is pressed.
You can add any kind of [python](https://www.python.org) code here.
To ensure a lag-free experience for the user, all actions on the pressed keys are executed in a dedicated thread. This means you can add time consuming code here without affecting the application. However, any actions on the button after that will be delayed to ensure that the actions are always called in the same order.

If you want to learn more about the available events see [ActionBase]().

```python
self.set_bottom_label(self.backend.get_number())
```
`self.set_bottom_label()` will change the bottom label on the key. To learn more about the available methods see [ActionBase](../bases/ActionBase_py.md).

`self.backend.get_number()` calls `get_number()` on the launched [backend](backend_py.md).