[StreamController](https:github.com/StreamController/StreamController) caches pages displayed by the deck. This improves performance while only using a bit more memory.

As a plugin developer, the internal caching mechanism is handled for you, so there's no need for direct intervention.  
However, it's important to be aware of its existence to circumvent potential issues:

### 1. `current_state` variables
: **Problem:**
    : If you use `current_state` variables in your actions to avoid updating the key image if it is not needed, congrats you're writing nice code.   
    Despite this, it's a common pitfall. Why? Because when a user navigates away from a page and then returns, your action's state might still be in the cache. Consequently, your plugin may falsely assume the correct image is displayed when, in fact, it is not.

: **Solution:**
    : To address this, simply reset the `current_state` variable within the [`on_ready`](../bases/ActionBase_py.md#on_ready) method. The `on_ready` method is invoked each time a page is loaded, allowing you to reset the `current_state` variable.