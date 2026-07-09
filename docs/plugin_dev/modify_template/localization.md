# Localization

So far every label in our plugin is hardcoded English: the action name "Simple Action", the switch title "Show label", and so on. Let's make them translatable so users in other languages see their own.

StreamController does the hard part: it picks the right translation for the user's language. You just provide the translations and look them up by a **key** instead of writing the text directly.

## 1. Turn on the locale file

Opt into the locale system by passing `use_legacy_locale=False` when your plugin starts up:

```python title="main.py" hl_lines="3"
class PluginTemplate(PluginBase):
    def __init__(self):
        super().__init__(use_legacy_locale=False)
```

## 2. Create `locales.csv`

Add a file called `locales.csv` to your plugin's root. It's a **semicolon-separated** table: the first column is the key, and each following column is a language.

```csv title="locales.csv"
key;en_US;de_DE
actions.simple.name;Simple Action;Einfache Aktion
actions.simple.show_label;Show label;Beschriftung anzeigen
actions.counter.name;Counter;Zähler
```

Add a column for every language you support. English is required.

## 3. Look up keys instead of text

Anywhere you had a literal string, use `self.locale_manager.get("key")`. It's available as `self.locale_manager` in your plugin and as `self.plugin_base.locale_manager` in an action. A short alias makes it tidy:

```python title="main.py" hl_lines="5 12 20"
class PluginTemplate(PluginBase):
    def __init__(self):
        super().__init__(use_legacy_locale=False)

        self.lm = self.locale_manager

        self.simple_action_holder = ActionHolder(
            plugin_base = self,
            action_core = SimpleAction,
            action_id_suffix = "SimpleAction",
            action_name = self.lm.get("actions.simple.name"),
            action_support = { Input.Key: ActionInputSupport.SUPPORTED }
        )
        self.add_action_holder(self.simple_action_holder)

        self.register(
            plugin_name = self.lm.get("actions.simple.name"),
            github_repo = "https://github.com/StreamController/PluginTemplate",
            plugin_version = "1.0.0",
            app_version = "1.5.0-beta.14"
        )
```

!!! warning "Never localize an `action_id`"
    Translate visible text only. If you localize an `action_id` (or its suffix), users who switch language will lose their configured actions.

## 4. Settings titles translate themselves

[Generative UI](config/generative_ui.md) rows run their `title`/`subtitle` through the locale system automatically. So you can hand a row a **key** instead of text:

```python
self.show_label_switch = SwitchRow(
    action_core=self,
    var_name="show_label",
    default_value=False,
    title="actions.simple.show_label"   # a locale key
)
```

If the key exists in `locales.csv` it's translated; otherwise the text is shown as-is.

---

!!! info "Older plugins: the JSON format"
    Before `locales.csv`, plugins used a `locales/` folder with one JSON file per language (`en_US.json`, …) and the default `use_legacy_locale=True`. You may still see this in existing plugins. It's read the same way, `self.locale_manager.get("key")`: but for new plugins prefer `locales.csv`.
