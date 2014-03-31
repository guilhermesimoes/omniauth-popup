# OmniAuth Popup

A simple example of how you could setup a pure OmniAuth login using a popup window. No javascript SDK needed. See it in action [here](http://omniauth-popup.herokuapp.com/).

## Code flow

There are 6 steps involved:

* [application_helper.rb](app/helpers/application_helper.rb) - A useful function that helps simplify the view. It adds a css class to be later used as a selector and adds some data attributes that determine the size of the popup.

* [application.html.erb](app/views/layouts/application.html.erb) - The user clicks some "Login with Social Provider" button.

* [login.js](app/assets/javascripts/login.js) - The click is intercepted by a small jQuery function that creates the popup. It also adds a simple `popup` param to be later checked by our server.

* The request goes through our server and hits the Social Provider's servers. If the user is not logged in, he is prompted to do so. If the user has not authorized this app before, he is prompted to do so too. If both of these conditions are met, this step can be skipped.

* [sessions_controller.rb](app/controllers/sessions_controller.rb) - A callback request hits our server. Here, the user account is searched for or created depending on whether this is the user's first time logging in or not. The `popup` param is checked for and if it exists that means the user has javascript enabled.

* [callback.html.erb](app/views/sessions/callback.html.erb) - A view made of javascript closes the popup and redirects the main window to the url the user was trying to access. If the `popup` param was not present in the previous step, the server itself would make the redirection to the correct url.

## How to run

First, install all the required gems with:

    bundle install --without production

Then follow the instructions on the file [application.template.yml](config/application.template.yml).

Finally, start a web server on port 3000 with:

    rails server

## References

* Create your Facebook app [here](https://developers.facebook.com/apps)

* Create your GitHub app [here](https://github.com/settings/applications/new)

* Create your Google app [here](https://code.google.com/apis/console)

* Create your Twitter app [here](https://dev.twitter.com/apps)
