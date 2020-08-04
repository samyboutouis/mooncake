# Mooncake

[Mooncake](mooncake.colab.duke.edu) is a web application created during my Code+ 2020 Summer Internship that aims to streamline the course registration process at Duke University. It creates a single platform where students and faculty interact and are able to request permission numbers to enroll in capacity-capped courses.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Requirements
```
Ruby version >= 2.6.6
```

### Clone the repository
```shell
git clone git@github.com:samyboutouis/mooncake.git
cd project
```

### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 2.6.6`

If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv):

```shell
rbenv install 2.6.6
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler) and [Yarn](https://github.com/yarnpkg/yarn):

```shell
bundle && yarn
```

### Initialize the database

```shell
rails db:create db:migrate db:seed
```

## Serve

```shell
rails s
```

## Acknowledgments

Thank you to... :D
* My 5 other team members
* My team leads Michael and Danai
* Duke SISS office and Office of the University Registrar
