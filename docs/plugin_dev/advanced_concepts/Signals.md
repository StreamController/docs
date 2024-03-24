Signals are called when special actions are performed in the ui, allowing the plugin to respond to these actions. For example, should your plugin have some kind of page selection in the [config area](../bases/ActionBase_py.md#get_config_rows) your plugin needs to get informed if a page gets renamed. That's exactly what signals are for.

## Available signals

### `PageRename`
: **Description**:  
    This signal is called whenever a page gets renamed in the `Page Manager`.

    **Callback arguments**:

    |Name|Description|Type|
    |---|---|---|
    |old_path|The old path of the page.|str|
    |new_path|The new path of the page.|str|

### `PageDelete`
: **Description**:  
    This signal is called whenever a page gets deleted in the `Page Manager`.

    **Callback arguments**:

    |Name|Description|Type|
    |---|---|---|
    |path|The path of removed the page.|str|

### `PageAdd`
: **Description**:  
    This signal is called whenever a page gets added in the `Page Manager`.

    **Callback arguments**:

    |Name|Description|Type|
    |---|---|---|
    |path|The path of the added page.|str|

### `ChangePage`
: **Description**:  
    This signal is called whenever a page gets changed in the `Page Manager`.

    **Callback arguments**:

    |Name|Description|Type|
    |---|---|---|
    |controller|The controller of deck where the page was changed.|[DeckController](DeckController.md)|
    |old_path|The old path of the page.|str|
    |new_path|The new path of the page.|str|

### `PluginInstall`
: **Description**:  
    This signal is called whenever a new plugin gets installed.

    **Callback arguments**:

    |Name|Description|Type|
    |---|---|---|
    |id|The id of the plugin e.g. `dev_core447_OSPlugin`|str

## How to use signals
1. Import the signals module
```python
from src.Signals import Signals
```
2. Connect to the signal  
This is done by the [`connect`](../bases/ActionBase_py.md#connect) method of the [`ActionBase`](../bases/ActionBase_py.md):
```python
self.connect(signal=Signals.PageRename, callback=self.on_page_rename)
```
3. Done !!  
Now every time a page gets renamed the `on_page_rename` method will be called.

## Not enough?
Should you need a signal that is currently not availble feel free to open a [issue](https://github.com/Core447/StreamController/issues) or work on an own [pull request](https://github.com/Core447/StreamController/pulls).