When non of the Listed problems here solve your problem create an issue on Github or join the Discord to get help.

To give you the help that is needed we would need the log or CLI output from StreamController

- To get the output of the CLI run:
    ```sh
    flatpak run com.core447.StreamController
    ```
- Afterward copy **EVERYTHING** that is in the CLI

Most of the time we can help just by getting this information, but sometimes we need to reproduce the Bug.
For that it would be best if you provide a list of steps to reproduce the behaviour.
An example could look like this:
```
1. Start StreamController
2. Open the manual page switcher
3. Rapidly change pages, at some point the page gets desynced
```

## 1. No decks found
When your system uses an older version of udev you might have to manually add some udev rules to your system.

??? info "Solution"
    ## 1. Conflicting apps
    Make sure that no other app is accessing your decks (check the autostart as well).
    ## 2. Missing udev rules
    1. Run: `sudo wget https://raw.githubusercontent.com/StreamController/StreamController/main/udev.rules -O /etc/udev/rules.d/60-streamdeck.rules`
    2. Restart your system: `reboot`

## 2. App stops if main window gets closed / Widgets freeze
This can happen if you're under Ubuntu because it might not allow StreamController to run in the background.

??? info "Solution"
    1. Open your system settings
    2. Navigate to Apps -> StreamController
    3. Enable "Run in background"
    ![run_in_background](assets/ubuntu_allow_to_run_in_background.png)