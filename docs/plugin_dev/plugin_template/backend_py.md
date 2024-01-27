This is the backend for the [BackendAction](BackendAction_py.md).
It's gets called by the following code of the [BackendAction](BackendAction_py.md):
```python title="BackendAction.py (partial)"
backend_path = os.path.join(os.path.dirname(__file__), "backend.py")
self.launch_backend(backend_path=backend_path)
```

[backend.py](backend_py.md) itself looks like this:
```python title="backend.py"
from streamcontroller_plugin_tools import BackendBase

import Pyro5.api

import time
import random

@Pyro5.api.expose
class Backend(BackendBase):
    def __init__(self):
        super().__init__()

    def get_number(self):
        return str(random.randint(0, 42))

if __name__ == "__main__":
    backend = Backend()
```

## [Pyro5](https://pyro5.readthedocs.io/en/latest/)
If you are working with dedicated backends like this one it it important to understand that if will be executed in a completely dedicated python process. This means no normal communication or imports of any [StreamController](https://github.com/Core447/StreamController) and [action](BackendAction_py.md) modules will be possible.  
Instead the communication is done via [Pyro5](https://pyro5.readthedocs.io/en/latest/).

Read more in [BackendAction#Pyro5](BackendAction_py.md#pyro5).

## Let's go over the code:

### BackendBase
```python
from streamcontroller_plugin_tools import BackendBase
```
This imports the [BackendBase](../bases/BackendBase_py.md) from [streamcontroller_plugin_tools](https://pypi.org/project/streamcontroller-plugin-tools/) which is the base class for all backends.
It will handle automatically connect to the [action](BackendAction_py.md) if launched from it.

### get_number()
```python
def get_number(self):
    return str(random.randint(0, 42))
```
This method returns a random number between 0 and 42 for testing purposes. It will be called by the [action](BackendAction_py.md) on the [key_down_event]().