Most actions don't need and use a dedicated backend. However, if you want to make heavy use of third party libraries or ones that interfere with the ones of the StreamController, you have to use a backend.

A backend in StreamController is a independant process that gets started by StreamController. StreamController will connect the backend to your action(s).

Running the backend in a dedicated process removes any limitations of the usable requirements.