#!/bin/bash

# 最新のコードを取得
git pull origin main

# 必要なGemをインストール
bundle install

# データベースのマイグレーションを実行 (必要に応じて)
RAILS_ENV=production bundle exec rails db:migrate

# アセットのプリコンパイル
RAILS_ENV=production bundle exec rails assets:precompile

# Pumaを再起動
sudo systemctl restart puma
