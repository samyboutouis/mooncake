# README


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


### Deployment
* Generate new secret file(only use as last resort)
`EDITOR="vim" bin/rails encrypted:edit config/new.cred.yml --key master.key.new`

### Permission Denied
* give access to user

`chown -R username .`

`chown -R :username .`
