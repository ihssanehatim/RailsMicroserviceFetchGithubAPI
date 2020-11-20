# Microservice Application for fetching most used languages over last 30 days :sunglasses:

_***What am I developping :star2: ?***_
-----------
A REST microservice that list the languages used by the 100 trending public repos on GitHub.

For every language we need the following information (attributes) :wink: :
    
* Number of repos using this language
* The list of repos using the language


Specifications
------------
* Ruby version

    ruby '2.6.5'

* How to run the test suite

* Deployment instructions

    *add deploy to heroku plugin*

* ...
Creating a new application

You can generate a new api Rails app:

```bash
    rails new my_api --api
```
This will do three main things for you:

    Configure your application to start with a more limited set of middleware than normal. Specifically, it will not include any middleware primarily useful for browser applications (like cookies support) by default.
    Make ApplicationController inherit from ActionController::API instead of ActionController::Base. As with middleware, this will leave out any Action Controller modules that provide functionalities primarily used by browser applications.
    Configure the generators to skip generating views, helpers, and assets when you generate a new resource.

eeeeee