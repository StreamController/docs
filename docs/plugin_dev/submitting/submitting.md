If you finished developing your plugin, you can submit it to the StreamController store by following these steps:

### 1. Test your plugin
Test your plugin for any issues.
Also read the [Page Caching](../advanced_concepts/PageCaching.md) section and check if your plugin works correctly if the user changes pages.

### 2. Verify requirements
Verify that all front-end/normal requirements of your plugin are found in `requirements.txt`.

### 3. Add your plugin to [GitHub](https://github.com)
In order to submit you plugin you have to publish your local repository to [GitHub](https://github.com).
If you have never used [GitHub](https://github.com) before, you can follow [this](https://docs.github.com/en/get-started/start-your-journey) tutorial.

### 4. Fork the [Store](https://github.com/StreamController/StreamController-Store)
Fork the Store repository into your own account.

### 5. Add your plugin to `Plugins.json`
Add an entry in `Plugins.json`:
```json title="Plugins.json"
{
    "url": "https://github.com/your-user-name/your-repo-name",
    "commits": {
        "1.1.1-alpha": "your-commit-hash"
    }
}
```
!!! info "Versions"
    Make sure to use the app version you used to develop and test your plugin.  
    App versions are in the format `breaking.feature.fix`.  
    StreamController will use the latest commit of your plugin with matching `breaking` version.

### 6. Open a pull request
Open a pull request to the [Store](https://github.com/StreamController/StreamController-Store) repository.  
[Creating a pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request)

### 7. Wait for approval
Wait for your pull request to be approved. This usually takes a couple of hours.