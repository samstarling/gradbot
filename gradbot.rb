require 'cinch'
require_relative 'plugins/tube.rb'
require_relative 'plugins/karma.rb'
require_relative 'plugins/thegrads.rb'
require_relative 'plugins/cat.rb'
require_relative 'plugins/lunchroulette.rb'
require_relative 'plugins/weather.rb'
require_relative 'plugins/celebtracker.rb'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = 'irc.dev.bbc.co.uk'
    c.port = '6697'
    c.nick = 'gradbot'
    c.channels = ['#thegrads', '#oldgrads']
    c.plugins.plugins = [TubeStatus, Karma, TheGrads, Cat, LunchRoulette, Weather, CelebTracker]
    c.ssl.use = true
    c.ssl.verify = false
    c.ssl.client_cert = '/home/samstarling/apps/gradbot/certificate.pem'
  end
end

bot.start