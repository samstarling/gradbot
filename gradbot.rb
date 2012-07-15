require 'cinch'
require_relative 'plugins/tube.rb'
require_relative 'plugins/karma.rb'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = 'irc.freenode.net'
    c.port = '6667'
    c.nick = 'gradbot'
    c.channels = ['#samstarling']
    c.plugins.plugins = [TubeStatus, Karma]
    #c.port = '6697'
    #c.server = 'irc.dev.bbc.co.uk'
    #c.ssl.use = true
    #c.ssl.verify = false
    #c.ssl.client_cert = '/Users/samstarling/certificate.pem'
  end
end

bot.start
