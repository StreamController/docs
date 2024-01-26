The [main.py](main_py.md) is the main file of your plugin and will be executed when the plugin is loaded.
Therefore this is the place where you can add your actions to your plugin.


Per default the file looks like this:  
```python title="main.py"
from src.backend.PluginManager.ActionBase import ActionBase # (1)
from src.backend.PluginManager.PluginBase import PluginBase # (2)

# Import gtk modules
import gi # (3)
gi.require_version("Gtk", "4.0") # (4)
gi.require_version("Adw", "1") # (5)
from gi.repository import Gtk, Adw # (6)

# Import actions
from .actions.Backend.BackendAction import BackendAction # (7)

class PluginTemplate(PluginBase): # (8)
    def __init__(self):
        self.PLUGIN_NAME = "PluginTemplate" # (9)
        self.GITHUB_REPO = "https://github.com/Core447/PluginTemplate" # (10)
        super().__init__() # (11)

        self.add_action(BackendAction) # (12)
```

1. Import the [ActionBase]() which is the base class for all actions.
2. Import the [PluginBase]() which is the base class for all plugins.
3. Import the [GTK bindings](https://www.gtk.org/docs/language-bindings/index)
4. Set the [GTK](https://www.gtk.org) version to [4.0](https://docs.gtk.org/gtk4/)
5. Set the [Adw](https://www.gtk.org) version to [1](https://gnome.pages.gitlab.gnome.org/libadwaita/doc/main/)
6. Import [GTK](https://www.gtk.org) and [Adw](https://www.gtk.org)
7. Import the [BackendAction]() which is the sample action with seperated backend.
8. Create a new plugin class by extending the [PluginBase]() class.
9. Set the name of your plugin. This will be shown in the ui but not in the store.
10. Set the link to your github repository. This will not be shown in the ui.
11. Initialize the base class.
12. Add the [sample action](BackendAction_py.md) to the plugin. This must be the class of the action not an instance.


## Let's go over the code:

### StreamController imports
```python
from src.backend.PluginManager.ActionBase import ActionBase
```
imports the [ActionBase]() which is the base class for all actions.

```python
from src.backend.PluginManager.PluginBase import PluginBase
```
imports the [PluginBase]() which is the base class for all plugins.

### Gtk import
```python
import gtk
gi.require_version("Gtk", "4.0")
gi.require_version("Adw", "1")
from gi.repository import Gtk, Adw
```
imports [Gtk](https://www.gtk.org/).
This is used for injecting configuration dialoges into the app.

### Import actions
```python
from .actions.Backend.BackendAction import BackendAction
```
imports the [BackendAction](BackendAction_py.md).
This is the sample action with seperated backend.

### The plugin class
```python
class PluginTemplate(PluginBase):
    def __init__(self):
        self.PLUGIN_NAME = "PluginTemplate"
        self.GITHUB_REPO = "https://github.com/Core447/PluginTemplate"
        super().__init__()

        self.add_action(BackendAction)
```
```PLUGIN_NAME``` is the name of your plugin. This will be shown in the ui.  
```GITHUB_REPO``` is the link to your github repository. This will not be shown in the ui.  
```super().__init__()``` initializes the base class.  
```self.add_action(BackendAction)``` adds the [sample action](BackendAction_py.md) to the plugin. This must be the class of the action not an instance.