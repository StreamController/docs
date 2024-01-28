The [ActionBase](ActionBase_py.md) is the base for all action in [StreamController](https://github.com/Core447/StreamController). Therefore all your actions must extend this class.  
[ActionBase.py](ActionBase_py.md) gives you easy access to the key(s) controlled by your actions, such as changing the image, getting events and so on.

If you want to learn more by going throught the code see [this](https://github.com/Core447/StreamController/blob/main/src/backend/PluginManager/ActionBase.py).

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
        The next tick loop will start one second after the last one finished. This means should there be some actions that take a bit longer to finish their ticks the delays will grow. Therefore [`on_tick`](#on_tick) should neither be used for time consuming code nor for precize timing.


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

### `set_key(self, image = None, media_path=None, margins=[0, 0, 0, 0], add_background=True, loop=True, fps=30, bypass_task=False, update_ui=True, reload: bool = False):`

### `set_label(self, text: str, position: str = "bottom", color: list[int] = [255, 255, 255], stroke_width: int = 0, font_family: str = "", font_size = 18, reload: bool = True)`

### `set_top_label(self, text: str, color: list[int] = [255, 255, 255], stroke_width: int = 0, font_family: str = "", font_size = 18, reload: bool = True):`

### `set_center_label(self, text: str, color: list[int] = [255, 255, 255], stroke_width: int = 0, font_family: str = "", font_size = 18, reload: bool = True):`

### `set_bottom_label(self, text: str, color: list[int] = [255, 255, 255], stroke_width: int = 0, font_family: str = "", font_size = 18, reload: bool = True):`

### `get_config_rows(self) -> list[Adw.PreferencesRow]`

### `get_custom_config_area(self) -> Gtk.Widget`

### `get_settings(self) -> dict`

### `set_settings(self, settings: dict)`

### `connect(self, signal:Signal = None, callback: callable = None)`

