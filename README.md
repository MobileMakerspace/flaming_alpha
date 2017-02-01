Flaming Alpha
================

Yet another makerspace membership management application.

I'm developing this software to replace SeltzerCRM with a Rails application that I can support and extend. My intent is to have a system I can make available to other officers and hosts for general member management while being comfortable deploying and supporting.

### Planned Features
* Authentication
* Authorization - role based
* User membership management
* Configurable membership plans

SeltzerCRM features I do not plan on supporting - plugin system and the highly configurable role rights.

## Installation
Ruby 2.2.5,
Rails 5.0.1,
Postgres 9.6.1

Clone the repo and install the required gems

    $ git clone https://github.com/MobileMakerspace/flaming_alpha.git
    $ cd flaming_alpha
    $ bundle install

Setup local environment

    # Modify ./config/secrets.yml
    # Modify ./config/database.yml
    $ rake db:create
    $ rake db:migrate
    $ rake db:test:prepare

Verify tests

    $ rspec

Run the app

    $ rails s

## Getting Started
1. Login using the seeded admin account created in `./config/secrets.yml`.
1. Change the admin password at `Edit User`
1. Add your plans.

## Contributing


## Credits
This application was generated with the [rails_apps_composer](https://github.com/RailsApps/rails_apps_composer) gem
provided by the [RailsApps Project](http://railsapps.github.io/).

## License
Copyright (C) 2016-2017 Dana Spisak

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

See the LICENSE.txt file for the full license.
