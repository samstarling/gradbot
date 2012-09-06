require 'rest-client'
require 'cinch'
require 'json'
require 'htmlentities'

class TubeStatus
  include Cinch::Plugin

  match /tube/
  
  def execute(m)
    response = JSON.parse(RestClient.get 'http://api.tubeupdates.com/?method=get.status&lines=central,circle,hammersmithcity,victoria')
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
