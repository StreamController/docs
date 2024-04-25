The [ActionBase](ActionBase_py.md) is the base for all actions in [StreamController](https://github.com/Core447/StreamController). Therefore all your actions must extend this class.  
[ActionBase](ActionBase_py.md) gives you easy access to the key(s) controlled by your actions and providing easy wrappers to change images, set labels and getting events.

If you want to learn more by going throught the code click [here](https://github.com/Core447/StreamController/blob/main/src/backend/PluginManager/ActionBase.py).

## Available methods
### `set_deck_controller`
: **Arguments**:

    |Argument|Default|Description|
    |---|---|---|
    |deck_controller|None|The deck controller of the action.|

    **Description**:

    !!! warning
        This is an internal method, do not call it manually unless you know what you are doing.
    This method gets called on the initialization of the action and sets the internal variable `deck_controller`.

### `set_page`
: **Arguments**:

    |Argument|Default|Description|
    |---|---|---|
    |page|None|The page of the action.|

    **Description**:

    !!! warning
        This is an internal method, do not call it manually unless you know what you are doing.
    This method gets called on the initialization of the action and sets the internal variable `page`.

### `set_coords`
: **Arguments**:

    |Argument|Default|Description|
    |---|---|---|
    |coords|None|The coords of the action|

    **Description**:

    !!! warning
        This is an internal method, do not call it manually unless you know what you are doing.
    This method gets called on the initialization of the action and sets the internal variable `coords`.

### `on_key_down`
: This method gets called when the action key is pressed. You can override this method in your action and add your own code.

    !!! info
        To ensure a lag-free experience for the user, all actions on the pressed keys are executed in a dedicated thread. This means you can add time consuming code here without affecting the application. However, any actions on the button after that will be delayed to ensure that the actions are always called in the same order.

### `on_key_up`
: This method gets called when the action key is released. You can override this method in your action and add your own code.

    !!! info
        To ensure a lag-free experience for the user, all actions on the released keys are executed in a dedicated thread. This means you can add time consuming code here without affecting the application. However, any actions on the button after that will be delayed to ensure that the actions are always called in the same order.

### `on_tick`
: This method gets called **every second** to allow live updates to the key. You can override this method in your action and add your own code.
    !!! info
        unlike [`on_key_down`](#on_key_down) and [`on_key_up`](#on_key_up) all actions on the same deck will be executed in the same thread. This means you are **not** supposed to add time consuming code here.
    !!! warning
        The next tick loop will start one second after the last one finished. This means should there be some actions that take a bit longer to finish their ticks, the delays will grow. Therefore [`on_tick`](#on_tick) should neither be used for time consuming code nor for precize timing.


### `on_ready`
: This method gets called after the app is fully loaded and the decks are ready to process all types of requests.
    !!! info
        The constructor of all actions gets called before the actual decks are ready to process any requests for image changes. For that reason you should use [`on_ready`](#on_ready) for the intial image change instead of relying on the constructor.

### `set_default_image`
: **Arguments**:

    |Argument|Default|Description|Type|
    |---|---|---|---|
    |image|None|The image to use|[PIL.Image](https://pillow.readthedocs.io/en/stable/reference/Image.html)|

    **Description**:  
    This sets the **default** image of the key. If the user or any other action tries to change the image their image will be used instead.

    !!! warning
        This is not implemented yet. Changes made through this method will be ignored.

### `set_default_label`
: **Arguments**:

    |Argument|Default|Description|Type|
    |---|---|---|---|
    |text|None|The text to display|str|
    |position|bottom|The position of the text relative to the key|str|
    |color|[255, 255, 255]|The color of the text|list[int]|
    |stroke_width|0|The stroke width of the text|int|
    |font_family|""|The font family of the text|str|
    |font_size|18|The font size of the text|int|

    **Description**:  
    This sets the **default** label of the key. If the user or any other action tries to change the label their label will be used instead.

    !!! warning
        This is not implemented yet. Changes made through this method will be ignored.

### `set_media`
: **Arguments**:

    |Argument|Default|Description|Type|
    |---|---|---|---|
    |image|None|The image to use|[PIL.Image.Image](https://pillow.readthedocs.io/en/stable/reference/Image.html)|
    |media_path|None|The path to a media file (can be a video, image or gif)|str|
    |size|1|The size of the image|float|
    |valign|0|The vertical alignment of the image (range -1 to 1)|float|
    |halign|0|The horizontal alignment of the image (range -1 to 1)|float|
    |loop|True|Whether to loop the video|bool|
    |fps|30|The frames per second of the video|int|
    |update|True|Whether to update the key|bool|

    **Description**:  
    This is the method you can use to change the content of the key.  
    As you can see you can show images as well as videos in all major formats.

### `set_background_color`:
: **Arguments**:

    |Argument|Default|Description|Type|
    |---|---|---|---|
    |color|[255, 255, 255, 255]|The color of the background|list[int]|
    |update|True|Whether to update the key|bool|

### `show_error`
: **Arguments**:

    |Argument|Default|Description|Type|
    |---|---|---|---|
    |duration|-1|The duration of the error in seconds. -1 means infinite|float|


### `set_label`
: **Arguments**:

    |Argument|Default|Description|Type|
    |---|---|---|---|
    |text|None|The text to display|str|
    |position|bottom|One of the three available positions: `top`, `center` or `bottom`|str|
    |color|[255, 255, 255]|The color of the text|list[int]|
    |stroke_width|0|The stroke width of the text|int|
    |font_family|""|The font family of the text|str|
    |font_size|18|The font size of the text|int|
    |update|True|Whether to update the key|bool|

    **Description**:  
    This method allows you write text in one of the three available positions: `top`, `center` or `bottom` onto the key.

### `set_top_label`
: **Arguments**:
    
    |Argument|Default|Description|Type|
    |---|---|---|---|
    |text|None|The text to display|str|
    |color|[255, 255, 255]|The color of the text|list[int]|
    |stroke_width|0|The stroke width of the text|int|
    |font_family|""|The font family of the text|str|
    |font_size|18|The font size of the text|int|
    |update|True|Whether to update the key|bool|

    **Description**:  
    This method has the same outcome as [`set_label`](#set_label) with `position = "top"`.

### `set_center_label`
: **Arguments**:
    
    |Argument|Default|Description|Type|
    |---|---|---|---|
    |text|None|The text to display|str|
    |color|[255, 255, 255]|The color of the text|list[int]|
    |stroke_width|0|The stroke width of the text|int|
    |font_family|""|The font family of the text|str|
    |font_size|18|The font size of the text|int|
    |update|True|Whether to update the key|bool|

    **Description**:  
    This method has the same outcome as [`set_label`](#set_label) with `position = "center"`.

### `set_bottom_label`
: **Arguments**:
    
    |Argument|Default|Description|Type|
    |---|---|---|---|
    |text|None|The text to display|str|
    |color|[255, 255, 255]|The color of the text|list[int]|
    |stroke_width|0|The stroke width of the text|int|
    |font_family|""|The font family of the text|str|
    |font_size|18|The font size of the text|int|
    |update|True|Whether to update the key|bool|

    **Description**:  
    This method has the same outcome as [`set_label`](#set_label) with `position = "bottom"`.
    
### `get_config_rows`
: **Description**:  
    This method can be overritten by your action to show configuration rows in the ui.
    <figure markdown>
    ![Example](../../assets/ConfigRows.png){width="300" align=left loading=lazy}
    <figcaption>Example from the [OS Plugin](https://github.com/Core447/OSPlugin)</figcaption>
    </figure>

    **Returns**:  
    A list of [Adw.PreferencesRow](https://gnome.pages.gitlab.gnome.org/libadwaita/doc/main/class.PreferencesRow.html) objects.

    !!! info
        If you need a brief intro into [GTK4](https://www.gtk.org/) in python you can check out [this tutorial](https://github.com/Taiko2k/GTK4PythonTutorial).
        For more involved information you can also check out the [GTK4 documentation](https://docs.gtk.org/gtk4/).

### `get_custom_config_area`
: **Description**:  
    This method can be overritten by your action to show a custom area in the ui. By allowing all [Gtk.Widgets](https://docs.gtk.org/gtk4/class.Widget.html) you are able to customize the config area completely to your needs.

    **Returns**:  
    Any [Gtk.Widget](https://docs.gtk.org/gtk4/class.Widget.html)

    !!! info
        If you need a brief intro into [GTK4](https://www.gtk.org/) in python you can check out [this tutorial](https://github.com/Taiko2k/GTK4PythonTutorial).
        For more involved information you can also check out the [GTK4 documentation](https://docs.gtk.org/gtk4/).

### `set_settings`
: **Arguments**:
    
    |Argument|Description|Type|
    |---|---|---|
    |settings|A dictionary with your settings|dict|

    **Description**:  
    This method allows you to store settings for your actions. The typical usage is to store the user settings made in the [`custom config area`](#get_custom_config_area). You then use [`get_settings`](#get_settings) to retrieve them.

    The dict gets directly written into the page json and will be kept if the page gets exported or duplicated. This looks like this:
    ```json hl_lines="4-8"
    "actions": [
                {
                    "name": "dev_core447_MediaPlugin::Info",
                    "settings": {
                        "show_thumbnail": true,
                        "show_label": true,
                        "seperator_text": ""
                    }
                }
            ]
    ```


### `get_settings`
: **Description**:  
    This method returns a dictionary with all your set settings for this action.
    For more see [`set_settings`](#set_settings).

    **Returns**:  
    A dictionary with your settings


### `connect`
: **Arguments**:

    |Argument|Default|Description|Type|
    |---|---|---|---|
    |signal|None|The signal to connect to|[Signal](../advanced_concepts/Signals.md)|
    |callback|None|A callback method|callable|

    **Description**:  
    This method allows you to connect to [signals](../advanced_concepts/Signals.md) allowing you to adapt to important changes made through the ui. For example if you are working with page names you might want to connect to the [page rename signal](../advanced_concepts/Signals.md#pagerename) to get notified when that happens and change the internal references accordingly.  
    [How to use signals](../advanced_concepts/Signals.md#how-to-use-signals)

### `launch_backend`
: **Description**:

    Launches a local backend. See [BackendBase](../bases/BackendBase_py.md).
    !!! warning
        The methods waits until the backend is registered.

: **Arguments**:

    |Argument|Default|Description|Type|
    |---|---|---|---|
    |backend_path|None|The path of the backend to launch.|str|
    |venv_path|None|The path of the venv to use.|str|
    |open_in_terminal|False|Open the backend in a terminal window. Useful for debugging.|bool

### `get_own_key`
: **Description**:
    Returns `ControllerKey` object holding this action.

### `get_is_multi_action`
: **Description**:
    Returns `True` if this action is a multi action.  
    If `True` all images operations should be disabled.

## Available Constants
### `HAS_CONFIGURATION`
: **Description**:
    Can be set to `True` or `False` to make an Action open the Configuration Page after it got added to a button
: **Default**: `False` 