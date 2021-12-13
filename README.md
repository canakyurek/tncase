# Tncase

* Lists popular TV shows from **TMDb API v3** and presents detail info when selected.
* Did not use any 3rd party library for networking. Instead, used own generic network layer based on enum and protocol. Did not modify the layer for reactive purposes.
##ViewModel objects handled the reactive parts and were binded to the related controllers.
 
# Which parts to improve?

* Segue approach creates an anti-pattern in this situation. Instead, controllers should not know about each other. Approaches such as **coordinator or navigator** could be better.
* Cache mechanism can be added for images.



