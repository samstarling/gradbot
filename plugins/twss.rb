require 'twss'

class ThatsWhatSheSaid
  include Cinch::Plugin

  listen_to :message, :method => :twss

  def twss(m, *args)
    if TWSS(m.message)
      sleep 1
      m.reply "#{m.user.nick}: That's what she said!"
    end
  end
end
