At some point the libraries used by [StreamController](https://github.com/Core447/StreamController) will not suffice for more complex plugins and actions. You'll need to add your own dependencies. This can be done by adding a `requirements.txt` file to root directory of your plugin.

!!! warning
    This method is only meant to be used for small libraries that are needed in the frontend and do not interfere with the ones of the StreamController.  
    If you need to use larger libraries, you will need to create a backend for your plugin or action.
    See [Add a backend action](add_a_backend_action.md) to learn more.