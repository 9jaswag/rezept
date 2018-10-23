# Rezept

Rezept is a recipe API built in Ruby on Rails. It can serve as the back-end to your recipe app. It allows you to create, modify and view recipes.

## Tech Stack
Rezept is built using:
- Ruby on Rails
- PostgreSQL

## API Documentation
You can find the documentation for this API [here](https://documenter.getpostman.com/view/3997090/RWgwSG6D).

## Get started
- Ensure you have Ruby, Ruby on Rails and PostgreSQL installed on your machine.
- Clone this repository:
```sh
$ git clone git@github.com:9jaswag/rezept.git
```
- Change into the `rezept` directory and checkout to the `develop` branch:
```sh
$ cd rezept
$ git checkout develop
```
- Install all dependencies:
```sh
$ bundle install
```
- Create an `application.yml` file in the `config` directory and copy the contents of `config/example.application.yml` into it. Replace the details there with your own details.
- Start the development server:
```sh
$ rails server
```
You're set to consume any endpoint at `http://localhost:3000/endpoint`.

## How to contribute
- Fork this repository.
- Clone it.
- Create your feature branch on your local machine with `git checkout -b your-feature-branch`
- Push your changes to your remote branch with `git push origin your-feature-branch`
- Open a pull request against the develop branch, and describe how your feature works

Want to see new features? Open an issue.

