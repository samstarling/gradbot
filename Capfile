desc "Deploy the gradbot!"
task :deploy, :hosts => "samstarling@samstarling.webfactional.com" do
  run "cd /home/samstarling/apps/gradbot && ruby1.9 server.rb stop"
  run "cd /home/samstarling/apps/gradbot && git reset --hard HEAD"
  run "cd /home/samstarling/apps/gradbot && git pull"
  run "cd /home/samstarling/apps/gradbot && ruby1.9 server.rb start"
  status = capture "cd /home/samstarling/apps/gradbot && ruby1.9 server.rb status"
  run "/home/samstarling/webapps/gradbot/bin/restart"
  puts status
end
