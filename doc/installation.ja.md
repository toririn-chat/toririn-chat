# インストール

## ソースコードの取得

```bash
$ git clone https://github.com/mh61503891/toririn-chat.git¬
$ cd toririn-chat
```

## パッケージのインストール

```bash
$ bundle config --local build.pg --with-pg-config=/Applications/Postgres.app/Contents/Versions/latest/bin/pg_config
$ bundle config --local build.nokogiri --use-system-libraries
$ bundle install
```

## 環境変数ファイルの設定

```bash
$ cp .env.example .env
```

```bash
$ cat .env
PORT=80
DATABASE_URL=postgres://postgres:@localhost:5432/toririn-chat_production
TZ=Asia/Tokyo
LANG=ja_JP.UTF-8
RAILS_ENV=production
RAILS_SERVE_STATIC_FILES=enabled
RAILS_LOG_TO_STDOUT=enabled
DISABLE_DATABASE_ENVIRONMENT_CHECK=1
```

Set `SECRET_KEY_BASE` to a generated secret key via `bundle exec rails secret`.

```bash
$ echo "SECRET_KEY_BASE=`bundle exec rails secret`" >> .env
```

## データベースの設定

```bash
$ bundle exec foreman run rails db:migrate:reset
$ bundle exec foreman run rails db:seed
```

## アセットのプリコンパイル

```bash
$ bundle exec foreman run rails assets:precompile
```

## サーバの起動

```bash
$ sudo bundle exec foreman start
```
