## 1. No decks found
When you're system uses an older version of udev you might have to manually add some udev rules to your system.

??? info "Solution"
    1. Run: `sudo wget https://raw.githubusercontent.com/StreamController/StreamController/main/udev.rules -O /etc/udev/rules.d/60-streamdeck.rules`
    2. Restart your system: `reboot`

## 2. App stops if main window gets closed / Widgets freeze
This can happen if you're under Ubuntu because it might doesn't allow StreamController to run in the background.

??? info "Solution"
    1. Open your system settings
    2. Navigate to Apps -> StreamController
    3. Enable "Run in background"
    ![run_in_background](assets/ubuntu_allow_to_run_in_background.png)