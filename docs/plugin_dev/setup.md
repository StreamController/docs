After you have come up with an [Idea](idea.md), all you have to do is put it into practice. 
<br/><br/>
To develop [StreamController](https://github.com/Core447/StreamController) plugins you need the source code of [StreamController](https://github.com/Core447/StreamController) itself.  
This allows you to deeply integrate your plugin into the application.

**Note:** Should your plugin require modification of the code of [StreamController](https://github.com/Core447/StreamController), you will need to open a pull request.
Just make sure that all requested changes outside of your plugin are generic ones and not specific to your plugin.
<br/><br/> 
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
6 Enter the plugins directory:
    
```sh
cd plugins
```
7. Clone the PluginTemplate from [GitHub](https://github.com/Core447/PluginTemplate) by typing:
    
```sh
git clone https://github.com/Core447/PluginTemplate
```

This will create a new directory called `PluginTemplate` in the plugins directory with a bunch of files. But no worry, I will explain each of them in the next section.