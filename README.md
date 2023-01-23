# Payment System ⚡

![Ruby version](https://img.shields.io/badge/ruby-3.1.2p20-red?color=red&label=ruby&logo=ruby&style=plastic) ![Ruby on Rails version](https://img.shields.io/badge/ruby%20on%20rails-7.0.4-blue?color=blue&style=plastic) ![Bundler version](https://img.shields.io/badge/bundler-2.3.26-blue?color=blue&style=plastic) 





## Welcome to this project 🎉 !
Payment system is a ruby on rails application allowing us to show off some programming skills, it's based on ruby on rails, docker, sidekiq, redis and some other basic dependencies...


## Dependencies
Payment system consists of a suite of dependencies (gems, packages, database, cache ...) among which docker plays a central role. Docker makes it possible to orchestrate the different dependencies of the application and to set up a single working environment independent of the operating system, thus making it possible to share consistency between the different development environments (linux, windows, mac). For a launch of the application or a build, docker-compose takes care of concentrating in the `docker-compose.yml` file the various container orchestration data, setting up volumes and any other docker instructions that we will need.

Basic dependencies:
- docker version 20.10.0 and higher
- docker-compose version 1.28.0 and higher

Dependencies on container:
- database: PostgreSQL 12, 13
- redis,
- git version 2
- node version 16.x et supérieures
- ruby 3.1.2
- rails 7.0.4
- sidekiq 6
- etc

Other dependencies are listed in `Gemfile` and `Gemfile.lock`.

## Installation
In order to run, test or even just `rails console` you will need a working docker and docker-compose instance.

You can install docker and docker-compose from the docker site:
- on Windows: https://docs.docker.com/desktop/install/windows-install/
- on Mac: https://docs.docker.com/desktop/install/mac-install/
- on Linux: https://docs.docker.com/desktop/install/linux-install/

Build application:
  - docker-compose build
  - docker-compose run web bin/rails db:reset


## Start application
> `docker-compose up` 

Application is then available on `localhost:3000`
 🙂

## Accounts to use
  ### admin account: `admin1@test.com`, password: `123passer`
  ### merchant account: `merchant1@test.com`, password: `passer123`

## Tests
Tests are based on rspec and capybara
To reset database: `docker-compose run web bin/rails db:reset`

To launch tests: `docker-compose run web bundle exec rspec`
## Jobs
Jobs are based on after_party for deployment jobs which would run only once(import users).
after_party jobs will run automatically on deploy if it never been performed before.

We also added sidekiq for scheduled jobs like the one to delete transactions older than 1 hour. Sidekiq jobs also are setup to run automatically at deploy.

## Rubocop linter

Run with: `docker-compose run web bundle exec rubocop`

## Happy new year!!! 🥳
