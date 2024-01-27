This is a typical [python requirements.txt](https://learnpython.com/blog/python-requirements-file/) file.  
It is used to specify the dependencies for the plugin in the form of [pip](https://pip.pypa.io/en/stable/) packages.

!!! Note
    The normal use case for this file is to declare the requirements for the [backend](backend_py.md) environment. Therefore the listed requirements will be only available in this environment. They are **not** available for the [actions](BackendAction_py.md).  
    If you want to have a look at how to use this file to setup the environment, head over to [\_\_install\_\_.py](__install___py.md).

The default requirements.txt looks like this:
```text
Pyro5>=5.15
streamcontroller-plugin-tools>=0.0.4
```
As you can see it imports the most important packages:

### [Pyro5](https://pyro5.readthedocs.io/en/latest/)
[Pyro5](https://pyro5.readthedocs.io/en/latest/) is used to establish a connection between the [action](BackendAction_py.md) and the [backend](backend_py.md).

### streamcontroller-plugin-tools
[streamcontroller-plugin-tools](https://pypi.org/project/streamcontroller-plugin-tools/) contains the [BackendBase](../bases/BackendBase_py.md) which you will need to create your own [backend](backend_py.md).