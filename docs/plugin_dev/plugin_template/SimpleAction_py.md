# Draw an Icon

Let's open the example action and understand how it draws that icon. Here's the whole file, it's short:

```python title="actions/SimpleAction/SimpleAction.py"
from src.backend.PluginManager.ActionCore import ActionCore
from src.backend.PluginManager.EventAssigner import EventAssigner
from src.backend.DeckManagement.InputIdentifier import Input


class SimpleAction(ActionCore):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        # (we'll look at this in the next step)
        self.add_event_assigner(EventAssigner(
            id="simple_action_pressed",
            ui_label="Pressed",
            default_events=[Input.Key.Events.DOWN, Input.Dial.Events.DOWN],
            callback=self.on_pressed
        ))

    def on_ready(self) -> None:
        self.set_media(media_path=self.get_asset_path("info.png"), size=0.75)

    def on_pressed(self, data) -> None:
        print("Pressed")
```

We'll cover the press (the `EventAssigner` and `on_pressed`) in the [next step](../modify_template/input_events.md). For now, focus on the drawing.

## An action is a class

```python
class SimpleAction(ActionCore):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
```

Every action extends **`ActionCore`**. You don't need to know what arguments it takes, just pass them straight through with `*args, **kwargs`.

## Draw in `on_ready`

```python
def on_ready(self) -> None:
    self.set_media(media_path=self.get_asset_path("info.png"), size=0.75)
```

`on_ready` runs once the deck is ready to display things. **This is where you set your initial image.**

- `get_asset_path("info.png")` gives the full path to a file in your plugin's `assets/` folder.
- `set_media(...)` puts it on the input. `size=0.75` makes it fill 75% of the key.

!!! info "Why not the constructor?"
    The deck isn't ready to draw when your action is first created, so setting the image in `__init__` wouldn't work. Always do your first draw in `on_ready`.

## Try it

Swap `info.png` for another image you drop into `assets/`, restart StreamController, and re-add the action. Your image appears on the key.

`set_media` also handles **GIFs and videos**: see [`set_media` in the reference](../bases/ActionCore_py.md#set_media). To put **text** on a key, you'd use `set_label`, which we'll reach for in the next steps.

Next, let's see how the app knew about this action in the first place: [registering it](main_py.md).
