require 'rubygems'
require 'nokogiri/html'

class Metrolink
  include Cinch::Plugin

  match /tram/

  def execute(m)
    url = "http://www.metrolink.co.uk/todaysdisruptions/index.asp?id=25"
    response = Nokogiri::HTML.parse(RestClient.get(url))
    heading = response.css("h3.pageHeading").first.text
    m.reply heading
  end
end