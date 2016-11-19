インストール

## ソースコードの取得

```bash
$ git clone https://github.com/mh61503891/toririn-chat.git¬
$ cd toririn-chat
```

パッケージのインストール


bundle config --local build.pg
--with-pg-config=/Applications/Postgres.app/Contents/Versions/latest
/bin/pg_config¬
bundle config --local build.nokogiri --use-system-libraries¬
bundle install

sudo xcodebuild -license
環境変数ファイルの設定

下記のように .env というファイルをRailsのプロジェクト直下に配置します。
.env は foreman が読み込んで実行時に使用します。

echo "SECRET_KEY_BASE=`bundle exec rails secret`" >> .env¬
echo PORT=80 >> .env¬
echo TZ=Asia/Tokyo >> .env¬
echo
DATABASE_URL=postgres://postgres:@localhost:5432/toririn-chat_produc
tion >> .env¬
echo LANG=ja_JP.UTF-8 >> .env¬
echo RAILS_ENV=production >> .env¬
echo RAILS_SERVE_STATIC_FILES=enabled >> .env¬
echo RAILS_LOG_TO_STDOUT=enabled >> .env¬
echo DISABLE_DATABASE_ENVIRONMENT_CHECK=1 >> .env
データベースの設定


bundle exec foreman run rails db:migrate:reset
アセットのプリコンパイル


bundle exec foreman run rails assets:precompile
サーバの起動


sudo bundle exec foreman start
Agreeing to the Xcode/iOS license requires admin privileges, please re-run as root via sudo.
bundle exec rails db:environment:set RAILS_ENV=production

bundle exec rails db:drop RAILS_ENV=production DISABLE_DATABASE_ENVIRONMENT_CHECK=1


sudo bundle exec foreman run rails db:migrate:reset
