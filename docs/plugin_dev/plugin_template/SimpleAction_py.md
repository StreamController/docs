```python title="SimpleAction.py"
# Import StreamController modules
from src.backend.PluginManager.ActionBase import ActionBase #(1)!
from src.backend.DeckManagement.DeckController import DeckController #(2)!
from src.backend.PageManagement.Page import Page #(3)!
from src.backend.PluginManager.PluginBase import PluginBase #(4)!

# Import python modules
import os

# Import gtk modules - used for the config rows
import gi
gi.require_version("Gtk", "4.0") #(5)!
gi.require_version("Adw", "1") #(6)!
from gi.repository import Gtk, Adw #(7)!

class SimpleAction(ActionBase):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        
    def on_ready(self) -> None:
        icon_path = os.path.join(self.plugin_base.PATH, "assets", "info.png")
        self.set_media(media_path=icon_path, size=0.75) #(8)!
        
    def on_key_down(self) -> None:
        print("Key down") #(9)!
    
    def on_key_up(self) -> None:
        print("Key up") #(10)!
```

1. Import the [ActionBase](../bases/ActionBase_py.md) class
2. Import the [DeckController](../advanced_concepts/DeckController.md) class - just used for typing
3. Import the Page class - just used for typing
4. Import the [PluginBase](../bases/PluginBase_py.md) class - just used for typing
5. Set the [GTK](https://www.gtk.org) version to [4.0](https://docs.gtk.org/gtk4/)
6. Set the [Adw](https://www.gtk.org) version to [1](https://gnome.pages.gitlab.gnome.org/libadwaita/doc/main/)
7. Import [GTK](https://www.gtk.org) and [Adw](https://www.gtk.org)
8. Set an icon for the action
9. Print "Key down" if the key is pressed
10. Print "Key up" if the key is released