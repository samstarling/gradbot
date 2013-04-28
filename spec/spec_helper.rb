require 'simplecov'
SimpleCov.start 'rails'
require 'rest-client'
require 'cinch'
require 'coveralls'
Coveralls.wear!

Dir[File.dirname(__FILE__) + '/../plugins/*.rb'].each {|file| require file }

ENV['karma_file'] = '/tmp/karma'

class TestHarness
  attr_reader :bot
  
  def initialize bot
    @bot = bot
  end
  
  def match msg
    @bot.handlers.each do |h|
      if h.pattern.prefix
        if /!#{h.pattern.pattern.source}/.match msg
          return true
        end
      else
        matches = h.pattern.pattern.match msg      
        is_message = h.event == :message
        if matches && is_message
          return true
        end
      end
    end
    return false
  end
  
  def match? msg
    if match msg
      return true
    else
      return false
    end
  end
end

def load_fixture filename
  file = File.open(File.join(File.dirname(__FILE__), "fixtures/#{filename}"), "rb")
  contents = file.read
end
