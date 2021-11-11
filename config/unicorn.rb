pid "/home/cap/shared/tmp/pids/unicorn.pid"
stderr_path File.expand_path('log/unicorn.log', File.dirname(File.dirname(__FILE__)))
stdout_path File.expand_path('log/unicorn.log', File.dirname(File.dirname(__FILE__)))

worker_processes 1
listen 8400

timeout 1230
preload_app true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

  old_pid = "#{ server.config[:pid] }.oldbin"
  unless old_pid == server.pid
    begin
      # SIGTTOU だと worker_processes が多いときおかしい気がする
      Process.kill :QUIT, File.read(old_pid).to_i
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
