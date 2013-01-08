require 'rubygems'
require 'nokogiri'

class Metrolink
  include Cinch::Plugin

  match /tram/

  def execute(m)
    url = "http://www.metrolink.co.uk/pages/news.aspx?serviceID=55"
    response = Nokogiri::HTML.parse(RestClient.get(url))
    heading = response.css("h2.pageHeading").first.text
    m.reply heading
  end
end
