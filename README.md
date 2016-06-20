# KPSmart

>  Making KPS Great Again

[![Build Status](https://travis-ci.org/team-great/kpsmart.svg?branch=master)](https://travis-ci.org/team-great/kpsmart)
[![Code Climate](https://codeclimate.com/github/team-great/kpsmart/badges/gpa.svg)](https://codeclimate.com/github/team-great/kpsmart)
[![Test Coverage](https://codeclimate.com/github/team-great/kpsmart/badges/coverage.svg)](https://codeclimate.com/github/team-great/kpsmart/coverage)

A SWEN301 group project to make a mail service built using Ruby on Rails

## How to run

Prerequisites:

 * `postgresql` 9.4 or above
 * `ruby` 2.2 or above
 * `bundler` 1.1 or above

Setup the project with:

 * `bundler install` installs all the required gems
 * `bundler exec rake db:create` create the database
 * `bundler exec rake db:migrate` migrate the database

Run the server with:

 * `bundler exec rails s` to start the rails web server

Testing:

 * `bundler exec rake test` to run the tests

