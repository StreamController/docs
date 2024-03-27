At some point the libraries used by [StreamController](https://github.com/Core447/StreamController) will not suffice for more complex plugins and actions. You'll need to add your own dependencies. This can be done by adding a `requirements.txt` file to root directory of your plugin.

!!! warning
    This method is only meant to be used for small libraries that are needed in the frontend and do not interfere with the ones of the StreamController.  
    If you need to use larger libraries, you will need to create a backend for your plugin or action.
    See [Add a backend action](add_a_backend_action.md) to learn more.

## Requirements with backends
If you use a backend (see [Add A Backend Action](add_a_backend_action.md)) you're able to create a own [environment](https://docs.python.org/3/library/venv.html) for it.

This is done by adding a `__install__.py` script to the root of your plugin. This will be run when the plugin is installed from the store.

```python title="__install__.py"
from streamcontroller_plugin_tools.installation_helpers import create_venv
from os.path import join, abspath, dirname

toplevel = dirname(abspath(__file__))
create_venv(join(toplevel, "backend", ".venv"), join(toplevel, "backend", "requirements.txt"))
```
The shown file will create a new `backend/.venv` folder and install all requirements from `backend/requirements.txt`