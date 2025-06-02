After you have come up with an [idea](idea.md), all you have to do is put it into practice. 
<br/><br/>
To develop [StreamController](https://github.com/Core447/StreamController) plugins you need the source code of [StreamController](https://github.com/Core447/StreamController) itself.  
This allows you to deeply integrate your plugin into the application.

!!! note
    Should your plugin require modification of the code of [StreamController](https://github.com/StreamController/StreamController), you will need to open a pull request.
    Just make sure that all requested changes outside of your plugin are generic ones and not specific to your plugin.
## 1. Clone StreamController:
Clone StreamController from [GitHub](https://github.com/StreamController/StreamController) by typing:
    
```sh
git clone https://github.com/StreamController/StreamController
```
## 2. Enter the `StreamController` directory:

```sh
cd StreamController
```
## 3. Create a [virtual environment](https://docs.python.org/3/library/venv.html):

```sh
python -m venv .venv
```
## 4. Activate the virtual environment:

```sh
source .venv/bin/activate
```
## 5. Install [pip](https://pypi.org/project/pip/) requirements:

```sh
pip install -r requirements.txt
```
## 6. Change the data path

[StreamController](https://github.com/Core447/StreamController) normally stores data in the `.var/app/com.core447.StreamController/data` directory. However, for development it is useful to change the path to a directory inside the cloned repository. I recommend using creating a `data` directory in the root of the repository.

Create the data directory:
```sh
mkdir -p data/plugins
```

You can then use the the `--data` argument to override the data path on launch. For example: `--data data`. Depending on your IDE you can also add this to your project configuration.

!!! note
    If you have installed [StreamController](https://github.com/Core447/StreamController) for your personal use as a Flatpak, this will not affect the data path of your Flatpak.


## 6 Enter the plugins directory:
    
```sh
cd data/plugins
```
## 7. Create a plugin repository by using the [Plugin Template](https://github.com/Core447/PluginTemplate):

Head over to [GitHub](https://github.com/Core447/PluginTemplate) and click on the green `Use this template` button. Follow the instructions.

The next step is to clone the newly created repository where `https://github.com/username/plugin-template` is the url to your plugin:
```sh
git clone https://github.com/username/plugin-template
```
This will create a new directory called `plugin-template` in the plugins directory with a bunch of files. But no worry, I will explain each of them in the next section.

## 8. Rename the `PluginTemplate` directory:

```sh
mv PluginTemplate com_example_plugin
```
!!! note
    The plugin name should be in reverse domain notation, but with underscores instead of periods. For example, `com_example_plugin`. You have to use underscores because python cannot handle periods in file and directory names.