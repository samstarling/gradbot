require 'cinch'
require_relative 'plugins/tube.rb'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = '127.0.0.1'
    c.port = '6697'
    c.nick = 'gradbot'
    c.channels = ['#thegrads']
    c.plugins.plugins = [TubeStatus]
  end
  
  on :join do |m|
    m.reply "A wild #{m.user.nick} appeared!"
  end

  on :message, "!londonlunch" do |m|
    m.reply "samstarling, MikeSpelling, PaulL: Lunch!"
  end
end

bot.start
