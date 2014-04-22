# This is a config file that is used by a lot of deployment/tools. (tux, Heroku, shotgun)

# When you type 'shotgun' into the console, it will use this file!

require './app'
run Sinatra::Application
