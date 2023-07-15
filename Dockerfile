# 2022年5月26日時点の最新安定版
FROM ruby:3.1.2

# railsコンソール中で日本語入力するための設定
ENV LANG C.UTF-8

# RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
# /var/lib/apt/lists配下のキャッシュを削除し容量を小さくする
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs \
    && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリの設定
# RUN mkdir /var/www/html
# ENV APP_ROOT /var/www/html
# WORKDIR $APP_ROOT
WORKDIR /var/www/html

# gemfileを追加する
ADD ./src/Gemfile /var/www/html/Gemfile
ADD ./src/Gemfile.lock /var/www/html/Gemfile.lock

# gemfileのinstall
RUN bundle install
ADD ./src /var/www/html

# puma.sockを配置するディレクトリを作成
RUN mkdir -p tmp/sockets