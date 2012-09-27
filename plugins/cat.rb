require 'nokogiri'
require 'rest-client'

class Cat
  include Cinch::Plugin

  match /cat/

  def execute(m)
    url = 'http://thecatapi.com/api/images/get?format=xml&results_per_page=1'
    xml = Nokogiri::XML(RestClient.get url)
    cat = xml.xpath('//url')
    if not cat.empty?
      m.reply cat.text
    end
  end
end
