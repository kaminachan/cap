server "18.178.232.171", user: "ubuntu", roles: %w{app db web}, my_property: :my_value

role :app, %w{ubuntu@18.178.232.171}
role :web, %w{ubuntu@18.178.232.171}
role :db, %w{ubuntu@18.178.232.171}

 set :ssh_options, {
   keys: %w(~/.ssh/key/202111sample-capistrano.pem),
   auth_methods: %w(publickey)
 }