require 'rest-client'
require 'json'
require 'htmlentities'

class TubeStatus
  include Cinch::Plugin

  match /tube/

  def execute(m)
    stations = 'central,circle,hammersmithcity,victoria'
    url = "http://api.tubeupdates.com/?method=get.status&lines=#{stations}"
    response = JSON.parse(RestClient.get url)
    parsed = response['response']
    if response['response']['lines']
      response['response']['lines'].each do |line|
        status = "#{line['name']} - #{line['status']}\n"
        m.reply HTMLEntities.new.decode(status)
      end
    else
      m.reply 'Epic tube fail'
    end
  end
end
