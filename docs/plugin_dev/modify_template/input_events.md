# React to Input

Remember this block we skipped in the action?

```python
self.add_event_assigner(EventAssigner(
    id="simple_action_pressed",
    ui_label="Pressed",
    default_events=[Input.Key.Events.DOWN, Input.Dial.Events.DOWN],
    callback=self.on_pressed
))
```

This is how your action reacts to input. When the button goes **down**, `on_pressed` runs. That's why you saw `Pressed` printed in your terminal.

## Event assigners

You react to input by registering **event assigners**. Each one connects a callback to one or more input events:

```python
def __init__(self, *args, **kwargs):
    super().__init__(*args, **kwargs)

    self.add_event_assigner(EventAssigner(
        id="simple_action_pressed",   # unique name within the action
        ui_label="Pressed",           # shown to the user (see "Remapping" below)
        default_events=[Input.Key.Events.DOWN, Input.Dial.Events.DOWN],
        callback=self.on_pressed
    ))

def on_pressed(self, data):
    print("Pressed")
```

The interesting part is `default_events`: it's a **list**, so one assigner can react to several events. Here `on_pressed` fires on both a **key** press and a **dial** press — which is why the same action works on a normal button *and* on a Stream Deck + dial.

## The available events

Events live on the input type they belong to:

| Input | Events you can use |
|---|---|
| `Input.Key.Events` | `DOWN`, `UP`, `SHORT_UP`, `HOLD_START`, `HOLD_STOP` |
| `Input.Dial.Events` | the key events, plus `TURN_CW`, `TURN_CCW`, `SHORT_TOUCH_PRESS`, `LONG_TOUCH_PRESS` |
| `Input.Touchscreen.Events` | `DRAG_LEFT`, `DRAG_RIGHT` |

## Make the dial do its own thing

Reacting the same way to a key and a dial press is fine, but a dial can also **turn**. Let's give turning its own behaviour by adding two more assigners:

```python
self.add_event_assigner(EventAssigner(
    id="turn_up",
    ui_label="Turn up",
    default_event=Input.Dial.Events.TURN_CW,
    callback=self.on_turn_up
))
self.add_event_assigner(EventAssigner(
    id="turn_down",
    ui_label="Turn down",
    default_event=Input.Dial.Events.TURN_CCW,
    callback=self.on_turn_down
))
```

(Use `default_event` for a single event, or `default_events=[...]` for several.)

## Letting the user remap events

Every assigner you give a `ui_label` automatically shows up in the action's settings, where the **user** can reassign it to a different event — for example moving "Pressed" from a short press to a long press. You get this for free; there's no UI to write.

## Declaring input support

One loose end: in [`main.py`](../plugin_template/main_py.md) we told StreamController which inputs the action supports:

```python
action_support = {
    Input.Key: ActionInputSupport.SUPPORTED,
    Input.Dial: ActionInputSupport.SUPPORTED,
    Input.Touchscreen: ActionInputSupport.UNSUPPORTED,
}
```

- `SUPPORTED` — you've tested it on this input.
- `UNTESTED` — it might work; the UI warns the user.
- `UNSUPPORTED` — it can't be placed on this input.

Since we just added dial-turning, `Input.Dial: SUPPORTED` is well earned.

Next: let's let the user configure the action — [add a setting](config/generative_ui.md).

---

!!! info "Coming from an older plugin?"
    Older actions overrode fixed `on_key_down` / `on_key_up` methods on `ActionBase`. Event assigners replace that approach and are what make dials and the touchscreen possible. The old methods still work on [`ActionBase`](../bases/ActionBase_py.md) if you ever meet them in existing code.
