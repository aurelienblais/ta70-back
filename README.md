<p align="center">
  <img width="638" height="134" src="https://image.noelshack.com/fichiers/2019/24/4/1560433822-logo.png">
</p>

# README

* Ruby version : 2.5.3
* Require a working postgres instance (use docker-compose)

# Setup

* `docker-compose up -d`
* `rails db:setup`
* `rails db:migrate`
* `rails s`
* Navigate to `localhost:3000`

# Updating
* `bundle`
* `rails db:migrate`

# Running tests
* `rspec`

# Api

Api Doc is available here : https://aurelienblais.github.io/ta70-back/apidoc.html
