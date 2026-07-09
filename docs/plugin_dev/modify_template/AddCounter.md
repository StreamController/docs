# Count & Display State

Our `SimpleAction` reacts to presses but forgets everything between them. Let's build a **second action** that remembers something: a counter that goes up each time you press it and shows the number on the key.

This introduces two ideas: keeping **state** on your action, and drawing **text** with `set_label`. It also gives you practice adding a second action to a plugin.

### 1. Add a new directory
Every action should live in its own subdirectory of `actions`.
```shell
mkdir /path_to_plugin/actions/counter
```
This creates a new folder `counter` in the `actions` directory. Feel free to change the name or path as long as it's inside the plugin's dir.
### 2. Create a new file for the action
```shell
touch /path_to_plugin/actions/counter/counter.py
```
This creates an empty file `counter.py`. In the next steps we'll fill it.
### 3. Programming the new action
Let's add a basic action to `counter.py`:

```python title="counter.py"
# Import StreamController modules
from src.backend.PluginManager.ActionCore import ActionCore

class Counter(ActionCore):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
```

That's a valid action already, it just doesn't do anything yet, and it isn't registered, so it won't show up in the UI.

### 4. Register the action
All actions have to be registered in the plugin's [plugin base](../bases/PluginBase_py.md), here in [main.py](../plugin_template/main_py.md).
First, import the new action below the import of `SimpleAction`:
```python
from .actions.counter.counter import Counter
```
Then create an [`ActionHolder`](../plugin_template/main_py.md#wrap-each-action-in-an-actionholder) for it and add it to the plugin:
```python title="main.py" hl_lines="8 25-35"
# Import StreamController modules
from src.backend.PluginManager.PluginBase import PluginBase
from src.backend.PluginManager.ActionHolder import ActionHolder
from src.backend.PluginManager.ActionInputSupport import ActionInputSupport
from src.backend.DeckManagement.InputIdentifier import Input

# Import actions
from .actions.SimpleAction.SimpleAction import SimpleAction
from .actions.counter.counter import Counter


class PluginTemplate(PluginBase):
    def __init__(self):
        super().__init__()

        ## Register actions
        self.simple_action_holder = ActionHolder(
            plugin_base = self,
            action_core = SimpleAction,
            action_id_suffix = "SimpleAction",
            action_name = "Simple Action",
            action_support = {
                Input.Key: ActionInputSupport.SUPPORTED,
                Input.Dial: ActionInputSupport.SUPPORTED,
                Input.Touchscreen: ActionInputSupport.UNSUPPORTED,
            }
        )
        self.add_action_holder(self.simple_action_holder)

        self.counter_action_holder = ActionHolder(
            plugin_base = self,
            action_core = Counter,
            action_id_suffix = "Counter",
            action_name = "Counter",
            action_support = {
                Input.Key: ActionInputSupport.SUPPORTED,
                Input.Dial: ActionInputSupport.SUPPORTED,
                Input.Touchscreen: ActionInputSupport.UNSUPPORTED,
            }
        )
        self.add_action_holder(self.counter_action_holder)

        # Register plugin
        self.register(
            plugin_name = "Template",
            github_repo = "https://github.com/StreamController/PluginTemplate",
            plugin_version = "1.0.0",
            app_version = "1.5.0-beta.14"
        )
```
!!! note
    The full `action_id` (formed as `<plugin_id>::<action_id_suffix>`) must be unique within your plugin.

### 5. Do something!!!
An action that does nothing is pointless, let's make it count presses and show the number on the input.

#### 1. Add a counter variable and an event assigner
Actions react to input by registering an [`EventAssigner`](input_events.md). We bind our handler to the key and dial "down" events so the counter works on both keys and dials:
```python title="counter.py" hl_lines="2 3 9 11-16"
# Import StreamController modules
from src.backend.PluginManager.ActionCore import ActionCore
from src.backend.PluginManager.EventAssigner import EventAssigner
from src.backend.DeckManagement.InputIdentifier import Input

class Counter(ActionCore):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.counter: int = 0

        self.add_event_assigner(EventAssigner(
            id="increment",
            ui_label="Increment",
            default_events=[Input.Key.Events.DOWN, Input.Dial.Events.DOWN],
            callback=self.on_increment
        ))
```

#### 2. Increment the counter and update the label
```python title="counter.py (partial)" hl_lines="3-5"
        ...

    def on_increment(self, data):
        self.counter += 1
        self.set_center_label(str(self.counter))
```

#### 3. Show the initial counter on load
```python title="counter.py (partial)" hl_lines="3-4"
        ...

    def on_ready(self):
        self.set_center_label(str(self.counter))
```

#### 4. The result
The final `counter.py` looks like this:
```python title="counter.py"
# Import StreamController modules
from src.backend.PluginManager.ActionCore import ActionCore
from src.backend.PluginManager.EventAssigner import EventAssigner
from src.backend.DeckManagement.InputIdentifier import Input

class Counter(ActionCore):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.counter: int = 0

        self.add_event_assigner(EventAssigner(
            id="increment",
            ui_label="Increment",
            default_events=[Input.Key.Events.DOWN, Input.Dial.Events.DOWN],
            callback=self.on_increment
        ))

    def on_ready(self):
        self.set_center_label(str(self.counter))

    def on_increment(self, data):
        self.counter += 1
        self.set_center_label(str(self.counter))
```

!!! tip
    Because we registered the handler as an event assigner with a `ui_label`, the user can remap what triggers the increment (for example to a long press or a dial turn) right from the action's settings. See [Handling Input & Events](input_events.md).
