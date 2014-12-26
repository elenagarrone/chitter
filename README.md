[![Code Climate](https://codeclimate.com/github/elenagarrone/chitter/badges/gpa.svg)](https://codeclimate.com/github/elenagarrone/chitter)
[![Test Coverage](https://codeclimate.com/github/elenagarrone/chitter/badges/coverage.svg)](https://codeclimate.com/github/elenagarrone/chitter)

Chitter
=========
As challenge for the fourth week of Makers we had to write a little Twitter clone, called Chitter, that allows the users to post messages to a public stream.
The code had to be deployed to Heroku with two separate staging deployment targets: staging and production.

Technologies:
------------
- Ruby
- Rspec
- Capybara
- Sinatra
- PSQL
- BCrypt
- DataMapper

On Heroku:
----------
######It's a work in progress
Staging:
https://live-chitter.herokuapp.com/
Production: https://staging-chitter.herokuapp.com/

To do:
-----
- [ ] request for new password;
- [ ] password token should be sent by email;

How to use:
----------
Clone the repo:
```shell
$ git clone https://github.com/elenagarrone/chitter.git
```
Change into the directory:
```shell
$ cd chitter
```
Supposing you have installed <a href='http://www.postgresql.org/'>PostgreSQL</a>, create the databases:
```shell
$ psql
> create database "chitter_development";
#and
> create database "chitter_test";
#after they have been created, type:
>\q
```
Install the gems:
```shell
$ bundle install
```
Try it on localhost:
```shell
$ rackup
#then on the browser go to:
localhost:9292
```

How to test it:
--------------
From inside the directory run:
```shell
$ rspec
```
