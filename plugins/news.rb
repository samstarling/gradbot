class News
  include Cinch::Plugin

  match /news/

  def execute(m)
    response = `curl -s "http://www.bbc.co.uk/news/" | grep -E -B 50 -m 1 "see-also|secondary-story-header" | sed 's/\&quot;/\"/g' | sed "s/\&#039;/'/g" | grep "<p>" | sed 's/^[^>]*>//g'` | sed 's/...$//g'
    m.reply "#{m.user.nick}: #{response}"
  end
end