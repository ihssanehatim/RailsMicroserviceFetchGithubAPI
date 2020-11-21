# Microservice Application for fetching most used languages over last 30 days :sunglasses:

_***What am I developing :star2: ?***_
-----------
A REST microservice that list the languages used by the 100 trending public repos on GitHub.

For every language we need the following information (attributes) :wink: :
    
* Number of repos using this language
* The list of repos using the language

_***How to use :star2: ?***_
---------------

using the REST standards , here is how you can use this API :

```
GET /api/v1/languages
```

**Result will be :**

       [
           {
               "language": "JavaScript",
               "number_of_repos": 15,
               "list_of_repos": [
                   "URL1",
                   "URL2",
                    ...
               ]
           },
           {
               "language": "Ruby",
               "number_of_repos": 5,
               "list_of_repos": [
                    "URL1",
                    "URL2",
                    ...
               ]
           },
           ...
       ]

Status : 

[200] => SUCCESS

[503] => Service Unavailable

[204] => No Content

[400] => Bad Request


Specifications
------------
* Ruby version

    ruby '2.6.5'
* Gem used for fetching

    **Excon** : to fetch the GITHUB API , Excon is a general HTTP(s) client and is particularly well suited to usage in API clients.  

* folder structure
```
app
└── controllers
    └── api
        └── v1
            ├── languages_controller.rb :
                In this controller there are two methods : index which calls 
                a private back_to_client method rendering both :
                adapted_data and status .
└── models
    └── api
        └── v1
            ├── helperHTTP.rb :
                In this class I am providing some methods related to fetching data from github
                using Excon .

            ├── language.rb :
                As we know that each language has 2 attributes to show as a final result,
                this model allows to define methods controlling the state of each language .

            ├── languageAdapter.rb :
                In this model I format and adapt the data resulting from Github API
                using first : a hash which contains as a key : the language , as a value :
                the instance of Language model .

```

* Deployment instructions

    [![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/ihssanehatim/RailsMicroserviceFetchGithubAPI)


**Go ahead and create a new Api with Rails :muscle:**
---------
You can generate a new api with Rails using the following command :

```bash
 rails new my_api --api
```
This will do three main things for you:


* Configure your application to start with a more limited set of middleware than normal. Specifically, it will not include any middleware primarily useful for browser applications (like cookies support) by default.

* Make ApplicationController inherit from ActionController::API instead of ActionController::Base. As with middleware, this will leave out any Action Controller modules that provide functionalities primarily used by browser applications.

* Configure the generators to skip generating views, helpers, and assets when you generate a new resource.

**To explore more** : [here](https://guides.rubyonrails.org/api_app.html)
