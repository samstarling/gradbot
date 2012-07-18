require 'rest-client'
require 'cinch'
require 'json'

class TubeStatus
  include Cinch::Plugin

  match /tube/
  
  def execute(m)
    response = JSON.parse(RestClient.get 'http://api.tubeupdates.com/?method=get.status&lines=central,circle,hammersmithcity')
    parsed = response['response']
    if response['response']['lines']
      response['response']['lines'].each do |line|
        m.reply "#{line['name']} - #{line['status']}\n"
      end
    else
      m.reply 'Epic tube fail'
    end
  end
end
