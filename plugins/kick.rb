require 'cinch'

class Kicker
  include Cinch::Plugin

  match /kick (\w+) (.+)/

  def execute(m, user, reason)
    Channel(channel).kick user, reason
  end
end