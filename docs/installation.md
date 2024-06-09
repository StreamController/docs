##Flatpak

: <a href='https://flathub.org/apps/details/com.core447.StreamController'><img width='200px' alt='Download on Flathub' src='https://flathub.org/assets/badges/flathub-badge-en.png'/></a>

##GitHub

1. Clone StreamController from [GitHub](https://github.com/Core447/StreamController) by typing:
    ```sh
    git clone https://github.com/Core447/StreamController
    ```
2. Enter the `StreamController` directory:
    ```sh
    cd StreamController
    ```
3. Create a [virtual environment](https://docs.python.org/3/library/venv.html):
    ```sh
    python -m venv .venv
    ```
4. Activate the virtual environment:
    ```sh
    source .venv/bin/activate
    ```
5. Install [pip](https://pypi.org/project/pip/) requirements:
    ```sh
    pip install -r requirements.txt
    ```

    !!! note

        Arch Linux (and possibly other distros) may need to install the following system packages using the distribution specific package manager:    
        ```
        xdg-desktop-portal xdg-desktop-portal-gtk libportal libportal-gtk4
        ```
    

6. Launch the app:
    ```sh
    python3 main.py
    ```

##udev

: For most cases, this should not be necessary, but there are some known cases where devices are not detected due to older versions of udev or missing rules. If, for some reason, your Stream Deck is not detected, please add [this](https://raw.githubusercontent.com/StreamController/StreamController/main/udev.rules) udev rules to your system with the following command:

    ```
    sudo wget https://raw.githubusercontent.com/StreamController/StreamController/main/udev.rules -O /etc/udev/rules.d/60-streamdeck.rules
    ```

    Then reload the rules with `sudo udevadm trigger` or restart your system. 
