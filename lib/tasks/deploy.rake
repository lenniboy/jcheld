ssh_user = "lenni@lenni.info" # for rsync deployment
remote_root = "webapps/jcheld"        # for rsync deployment

desc "Clears the styles, generates new ones and then deploys the theme"
task :deploy do
  system("touch tmp/restart.txt")
  puts "*** Deploying the site ***"
  sh "rsync -r --exclude=log/* --exclude=script/* --exclude=.git/* . #{ssh_user}:#{remote_root}"
  puts "*** Restarting server ***"
  puts "*** Copying remote development.sqlite to production.sqlite ***"
  sh "scp db/development.sqlite3 #{ssh_user}:#{remote_root}/db/production.sqlite3"
  puts "*** Deleting CSS cache ***"
  sh "ssh #{ssh_user} \"rm ~/webapps/jcheld/public/stylesheets/styles.css\""
end
