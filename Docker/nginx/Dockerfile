# 2022年5月26日時点の最新版
FROM nginx:1.21.6

# インクルード用のディレクトリ内を削除
# RUN rm -f /etc/nginx/conf.d/*

WORKDIR /app


# # Nginxの設定ファイルをコンテナにコピー
# ADD nginx.conf /etc/nginx/conf.d/nginx.conf

# # ビルド完了後にNginxを起動
# CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf