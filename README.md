# MyWay: The Sinatra framework with infinite possibilities
[![Build Status](https://travis-ci.org/J-Mo63/myway-sinatra-api.svg?branch=master)](https://travis-ci.org/J-Mo63/myway-sinatra-api)
[![Maintainability](https://api.codeclimate.com/v1/badges/4bdd19a076d4fa065a59/maintainability)](https://codeclimate.com/github/J-Mo63/myway-sinatra-api/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/4bdd19a076d4fa065a59/test_coverage)](https://codeclimate.com/github/J-Mo63/myway-sinatra-api/test_coverage)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/dwyl/esta/issues)


MyWay is a **barebones Sinatra framework with modular boilerplates that provide examples for both API and web-app usage**... and it's super suave.

Its structure has been built out to emulate that of Ruby on Rails and as such is naturally quite opinionated. That being said however, the project's logic is easy enough to follow and **can easily be modified to suit your needs**.


## Getting Started

Simply have bundle installed and run it in the project directory:

```bash
$ bundle
```

## Running the Project

To get the project running at `localhost:3000` run:

```bash
$ puma
```

## The Project Structure

```
[root]
     |
     |-[api]
     |     |
     |     |-[v1]    <- API files suffixed with `_api.rb`
     |
     |-[config]      <- Configuration files for the application, models and webserver
     |
     |-[controllers] <- Controller files suffixed with `_controller.rb`
     |
     |-[helpers]     <- Helper files suffixed with `_helper.rb`
     |
     |-[models]      <- Model files suffixed with `_model.rb`
     |
     |-[public]      <- A public assets folder
     |
     |-[spec]
     |      |
     |      |-[v1]   <- Test files suffixed with `_spec.rb`
     |
     |-[views]       <- A module-organized views folder
```

## Testing

To test the project run:

```bash
$ rspec
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## To Do

* ~~Base App With Modular Controllers~~
* ~~API Boilerplate Module~~
* ~~Use Puma for Server~~
* ~~Make Heroku-Ready~~
* ~~Automatic Code Reloading~~
* ~~Controller Tests~~
* ~~Set Up Travis~~
* ~~Set Up CodeClimate~~
* ~~Add ORM~~
* ~~Add User Model~~
* Add Authentication Boilerplate