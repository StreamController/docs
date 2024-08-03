# Installation

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

        On Arch Linux (and possibly other distros) you may need to install the following system packages using the distribution specific package manager:
        ```
        xdg-desktop-portal xdg-desktop-portal-gtk libportal libportal-gtk4
        ```
    
6. Optional: Switch branches

    If you want to try out a specific branch, you can change the branch using:
    ```sh
    git checkout <branch>
    ```    

7. Launch the app:
    ```sh
    python3 main.py
    ```

##Unofficial packages
The following packages are functional but **unofficial** and maintained by our community:

[![Packaging status](https://repology.org/badge/vertical-allrepos/streamcontroller.svg)](https://repology.org/project/streamcontroller/versions)

---

# Help
If you encounter any problems, please go through [Common Problems](common_problems.md). You can also open an issue on the [StreamController GitHub repository](https://github.com/Core447/StreamController) or on the [Discord](https://discord.gg/MSyHM8TN3u).