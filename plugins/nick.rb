class News
  include Cinch::Plugin

  match /nick (\w+)/
  
  def execute(m, nick)
    if m.user.nick == "samstarling"
      @bot.nick = nick
    end
  end
end
