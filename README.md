# README


### App Setup up

* Install docker

* Build docker container

`docker-compose build`

* Start docker container and server

`docker-compose up`

* Open web application on browser

`localhost:3000` in web browser

* Stop docker container and server

`docker-compose down`

* Work in the container
 
`docker-compose exec app bash`


### Git housekeeping

* Push code to development branch only


`'git fetch && git checkout <branch>'`

`'git push origin <branch>'`



### DB

* Migrate the database

`rails db:migrate`

* Seed data

`rails db:seed`



### Deployment
* Generate new secret file(only use as last resort)
`EDITOR="vim" bin/rails encrypted:edit config/new.cred.yml --key master.key.new`