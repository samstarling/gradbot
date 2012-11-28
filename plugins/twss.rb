require 'twss'

class TWSS
  include Cinch::Plugin

  listen_to :message, :method => :twss

  def twss(m, *args)
    if TWSS(m.message)
      m.reply "#{m.user.nick}: That's what she said!"
    end
  end
end
