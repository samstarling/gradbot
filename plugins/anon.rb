require 'cinch'

class Anonymous
  include Cinch::Plugin

  match /anon (#\w+) (.+)/

  def execute(m, channel, msg)
    Channel(channel).send msg
  end
end