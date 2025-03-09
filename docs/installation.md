# Installation

##Flatpak

: <a href='https://flathub.org/apps/details/com.core447.StreamController'><img width='200px' alt='Download on Flathub' src='https://flathub.org/assets/badges/flathub-badge-en.png'/></a>

##GitHub
1. System Dependencies

    Please follow the guide that matches your distro the most:
    ??? info "Arch Linux"
        On Arch Linux (and possibly other distros) you may need to install the following system packages using the distribution specific package manager:
        ```
        xdg-desktop-portal xdg-desktop-portal-gtk libportal libportal-gtk4
        ```

    ??? info "Ubuntu Linux"
        On Ubuntu Linux (tested on 24.04.1 LTS) you may need to install the following system packages using the distribution specific package manager:
        ```
        gir1.2-xdpgtk4-1.0 libgirepository1.0-dev libportal-gtk4-1 libportal-gtk4-dev build-essential libdbus-glib-1-dev
        ```

2. Clone StreamController from [GitHub](https://github.com/Core447/StreamController) by typing:
    ```sh
    git clone https://github.com/Core447/StreamController
    ```
3. Enter the `StreamController` directory:
    ```sh
    cd StreamController
    ```
4. Create a [virtual environment](https://docs.python.org/3/library/venv.html):
    ```sh
    python3 -m venv .venv
    ```
5. Activate the virtual environment:
    ```sh
    source .venv/bin/activate
    ```
6. Install [pip](https://pypi.org/project/pip/) requirements:
    ```sh
    pip install -r requirements.txt
    ```

7. Optional: Switch branches

    If you want to try out a specific branch, you can change the branch using:
    ```sh
    git checkout <branch>
    ```    

8. Launch the app:
    ```sh
    python3 main.py
    ```

##Unofficial packages
The following packages are functional but **unofficial** and maintained by our community:

[![Packaging status](https://repology.org/badge/vertical-allrepos/streamcontroller.svg)](https://repology.org/project/streamcontroller/versions)

---

# Help
If you encounter any problems, please go through [Common Problems](common_problems.md). You can also open an issue on the [StreamController GitHub repository](https://github.com/Core447/StreamController) or on the [Discord](https://discord.gg/MSyHM8TN3u).
