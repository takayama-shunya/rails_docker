# config/unicorn.rb

# Railsアプリのルート
rails_root = File.expand_path('../../', __FILE__)

# Gemfileの場所
ENV['BUNDLE_GEMFILE'] = rails_root + "/Gemfile"

# ワーカープロセス数
worker_processes 2
# タイムアウト秒数
timeout 60
# アプリケーションのディレクトリを指定
working_directory rails_root
# ソケットファイルのパス
listen            File.expand_path 'tmp/sockets/.unicorn.sock', rails_root
# PIDファイルのパス
pid               File.expand_path 'tmp/pids/unicorn.pid', rails_root
# ログファイルのパス
stdout_path       File.expand_path 'log/unicorn.log', rails_root
stderr_path       File.expand_path 'log/unicorn.log', rails_root
# プロセスの停止などに必要な設定
preload_app true
GC.respond_to?(:copy_on_write_friendly=) && GC.copy_on_write_friendly = true

# リクエストを受け付けるためのソケットファイルの設定
before_fork do |server, worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.connection.disconnect!
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      Process.kill "QUIT", File.read(old_pid).to_i
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

# プロセスがフォークされた後に行う処理
after_fork do |server, worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
end
