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

## Not listed
If none of the listed problems resolve your issue, please create an issue on [GitHub](https://github.com/StreamController/StreamController) or join our [Discord](https://discord.gg/MSyHM8TN3u) for help.

To provide the necessary help, we need the log or CLI output from StreamController. Perform the following steps to get the CLI output:

1. Stop running instances of StreamController using the option in the hamburger menu

2. Run the following command to start the app:
    ```sh
    flatpak run com.core447.StreamController
    ```
3. Afterward copy everything that is in the CLI. You may want to remove your personal user name from it. To do this use an editor with search and replace functionality like [gedit](https://flathub.org/apps/org.gnome.gedit).

Most of the time this information is sufficient, but sometimes we need to reproduce the issue. In such cases, please provide a list of steps to reproduce the behaviour.
An example could look like this:
```
1. Start StreamController
2. Open the manual page switcher
3. Rapidly change pages, at some point the page gets desynced
```