


### Update

```sh
$ brew upgrade yarn
$ anyenv update
$ ndenv install --list
$ ndenv install 10.11.0
$ ndenv global 10.11.0
$ ndenv rehash
```

```sh
$ yarn upgrade-interactive --latest
```

Note: the following packages are installed by `bundle exec rails webpacker:install` and `bundle exec install rails webpacker:install:vue`.

```json
"dependencies": {
  "@rails/webpacker": "3.5",
  "vue": "^2.5.17",
  "vue-loader": "14.2.2",
  "vue-template-compiler": "^2.5.17"
},
"devDependencies": {
  "webpack-dev-server": "2.11.2"
}
```

### URLs

- http://localhost:3000
- http://localhost:3000/letter_opener

```sh
$ bundle exec rails db:migrate:reset
$ bundle exec rails db:fixtures:load FIXTURES=users,rooms,user_rooms,avatar_groups,avatars,people,messages
```
