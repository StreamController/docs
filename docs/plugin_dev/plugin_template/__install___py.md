The [\_\_install\_\_.py](__install___py.md) file is run when the plugin is installed from the [StreamController](https://github.com/Core447/StreamController) store.

It should be used to set up everything your plugin needs. The most common task is to create a dedicated environment for the [backend](backend_py.md).

```python title="__install__.py"
from streamcontroller_plugin_tools.installation_helpers import create_venv
from os.path import join, abspath, dirname

toplevel = dirname(abspath(__file__))
create_venv(path=join(toplevel, ".venv"), path_to_requirements_txt=join(toplevel, "requirements.txt"))
```
The shown default file will just create a [venv](https://docs.python.org/3/library/venv.html) in the plugin's folder and install all requirements from [requirements.txt](requirements_txt.md).

If your plugin needs additional setup steps, feel free to add them.