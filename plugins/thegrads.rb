require 'cinch'

class TheGrads
	include Cinch::Plugin

	listen_to :join

	def listen(m)
		if m.user.nick == bot.nick
			m.channel.topic = "The Grads"
      m.channel.mode = "-t"
		end
	end
end
