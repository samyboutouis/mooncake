# README

This is a Rails application that will ease the course permission number granting
process for students and faculty. In order to properly run this application,
make sure the following steps are completed.

* Set Ruby version to 2.7.0

`rvm use 2.7.0`

* Install bundle

`bundle install`

*  Check files with yarn 

`yarn install --check-files`

* Start the server 

`rails server`

or

`rails s`

### App Setup up

* Install docker

* Build docker container

`docker-compose build`

* Start docker container and server

`docker-compose up`

* Start docker container and run server in the background

`docker-compose up -d`

* Open web application on browser

`localhost:3000` in web browser

* Stop docker container and server

`docker-compose down`

* Run terminal to work in the container

`docker-compose exec app bash`


### Git housekeeping

* Push code to development branch only

`git fetch && git checkout development`

`git push origin development`

* Switch to specific branch

`git checkout [branch_name]`

* Push to specific branch 

`git push origin [branch_name]`


### DB
* Drop existing the database

`rails db:drop`

* Migrate the database

`rails db:migrate`
