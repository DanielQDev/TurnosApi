# Turnos Api

## Requirements
```
    - Ruby '3.3.0'
    - Rails >= 7.1.3.4
    - Postgresql
```

## Settings
### Add rails db credentials
```
    1. $ bundle install
    2. $ EDITOR='nano <or your editor> --wait' rails credentials:edit
    3. $ set database: 
              username: postgres or your user
              password: database password
    2. $ Save changes in your editor
```
### Run project
```
    1. $ rails db:create
    2. $ rails db:migration
    3. $ rails db:seed
    4. $ rails serve
```

### Run test
```
    1. $ rails db:test:prepare 
    2. $ rspec
```