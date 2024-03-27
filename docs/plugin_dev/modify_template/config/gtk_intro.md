StreamController allows plugins to inject [GTK](https://www.gtk.org) widgets into the action configuration area for configuration of the actions.

## [GTK](https://www.gtk.org)
[GTK](https://www.gtk.org) is a cross-platform GUI toolkit for creating graphical user interfaces. It is a free and open-source toolkit for developing applications with a focus on high quality and customization.

### Getting Started
Good resources to get started with [GTK](https://www.gtk.org) in python:

- [GTK4 Python Tutorial by Taiko2k](https://github.com/Taiko2k/GTK4PythonTutorial)
- [GTK4 Docs](https://docs.gtk.org/gtk4/)

!!! info
    If you feel overwhelmed by [GTK](https://www.gtk.org) I have good news for you:

    1. You don't need to know much about [GTK](https://www.gtk.org) to add config rows to your actions.
    2. You can check out [other plugins](../../intro.md#official-plugins) to see how they implemented config rows.
    3. Feel free to ask any questions on the [StreamController Discord](https://discord.gg/MSyHM8TN3u)


## Action Configuration Area
![ActionConfigurationArea](../../../assets/config_areas_marked.png)

The configuration area is splitted into two parts:
: #### Custom config rows (marked blue)
Here plugins can add [Adw.PreferencesRow](https://gnome.pages.gitlab.gnome.org/libadwaita/doc/main/class.PreferencesRow.html) widgets.  
See [`get_config_rows`](../../bases/ActionBase_py.md#get_config_rows) for more information about the implementation.

: #### Custom config area (marked green)
Here plugins can add any [Gtk.Widgets](https://docs.gtk.org/gtk4/class.Widget.html) widgets allowing more options for customization but also requiring more work.  
See [`get_custom_config_area`](../../bases/ActionBase_py.md#get_custom_config_area) for more information about the implementation.