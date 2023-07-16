# 2022年5月26日時点の最新安定版
FROM ruby:3.1.2


# RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
# /var/lib/apt/lists配下のキャッシュを削除し容量を小さくする
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /app
WORKDIR /app
ADD ./src/Gemfile /app/Gemfile
ADD ./src/Gemfile.lock /app/Gemfile.lock
RUN bundle install
# Unicornの設定ファイルをコピー
COPY ./Docker/rails/unicorn.rb /app/config/unicorn.rb

# RUN mkdir -p /app/tmp/pids && \
#     chmod -R 777 /app/tmp/pids

ADD ./src /app

# 3000番ポートを開放
EXPOSE 3000

# Unicornサーバーの起動
# CMD ["bundle", "exec", "unicorn", "-c", "config/unicorn.rb"]