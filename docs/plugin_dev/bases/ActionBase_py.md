!!! warning "`ActionBase` is deprecated"
    `ActionBase` has been replaced by [`ActionCore`](ActionCore_py.md). It still works — existing plugins do **not** break — but new actions should extend [`ActionCore`](ActionCore_py.md) instead. `ActionBase` now emits a deprecation warning and is only a thin backward-compatibility wrapper.

## What `ActionBase` is now

`ActionBase` subclasses [`ActionCore`](ActionCore_py.md) and adds two things purely for backward compatibility:

1. It registers the classic key/dial/touchscreen [event assigners](../modify_template/input_events.md) up front, wired to a compatibility `event_callback`.
2. It re-adds the old `on_key_down()` / `on_key_up()` hooks, which the compatibility `event_callback` dispatches to (key **down** and dial **down** → `on_key_down`, key/dial **up** → `on_key_up`).

Everything else — `set_media`, `set_label`, `get_settings`, `connect`, `launch_backend`, … — lives on [`ActionCore`](ActionCore_py.md) and is inherited unchanged. See the [`ActionCore` reference](ActionCore_py.md) for the full method surface.

## Migrating from `ActionBase` to `ActionCore`

|Old (`ActionBase`)|New (`ActionCore`)|
|---|---|
|`class MyAction(ActionBase)`|`class MyAction(ActionCore)`|
|Override `on_key_down` / `on_key_up`|Register an [`EventAssigner`](../modify_template/input_events.md) with `add_event_assigner(...)`|
|`HAS_CONFIGURATION = True` class constant|`self.has_configuration = True` instance attribute|
|Manual `get_config_rows` with hand-wired Adw rows|[Generative UI](../modify_template/config/generative_ui.md) rows|
|`stroke_width=` on labels|`outline_width=` on labels|

Registering an action still happens through an [`ActionHolder`](../plugin_template/main_py.md). `ActionHolder` accepts both the new `action_core=` and the legacy `action_base=` keyword, so a partly-migrated plugin keeps working.

Two methods were also removed/renamed on the class itself:

- `set_default_image` / `set_default_label` — these never did anything (were "not implemented") and no longer exist. Set your image/label in [`on_ready`](ActionCore_py.md#on_ready) instead.
- `has_label_control()` (returning a list) → `has_label_control(label_index)` plus `has_label_controls()` for the full list.
- `set_event_assignments(dict)` → `set_event_assignment(input_event, event_assigner)`.
