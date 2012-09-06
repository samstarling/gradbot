require 'cinch'
require 'nokogiri'

class Cat
  include Cinch::Plugin

  match /cat/
  
  def execute(m)
    xml = Nokogiri::XML(RestClient.get 'http://thecatapi.com/api/images/get?format=xml&results_per_page=1')
    m.reply xml.xpath('//url').text
  end
end
