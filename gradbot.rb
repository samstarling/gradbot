require 'cinch'
Dir[File.dirname(__FILE__) + '/plugins/*.rb'].each {|file| require file }

bot = Cinch::Bot.new do
  configure do |c|
    c.server = 'irc.dev.bbc.co.uk'
    c.port = '6697'
    c.nick = 'gradbot'
    c.channels = ['#thegrads', '#oldgrads']
    c.plugins.plugins = [
      TubeStatus,
      Karma,
      TheGrads,
      Cat,
      LunchRoulette,
      Weather,
      CelebTracker,
      Metrolink
    ]
    c.ssl.use = true
    c.ssl.verify = false
    c.ssl.client_cert = '/home/samstarling/apps/gradbot/certificate.pem'
  end
end

bot.start