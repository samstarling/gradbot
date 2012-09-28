require 'nokogiri'
require 'rest-client'

class CatApiClient
  def self.get_cat
    url = 'http://thecatapi.com/api/images/get?format=xml&results_per_page=1'
    xml = Nokogiri::XML(RestClient.get url)
    element = xml.xpath('//url')
    if element && element.text != ""
      element.text
    else
      nil
    end
  end
end

class Cat
  include Cinch::Plugin

  match /cat/

  def execute(m)
    cat = CatApiClient.get_cat
    m.reply cat if cat
  end
end
