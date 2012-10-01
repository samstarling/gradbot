require 'rest-client'
require 'simplecov'
require 'cinch'
SimpleCov.start

require_relative '../plugins/cat'
require_relative '../plugins/celebtracker'
require_relative '../plugins/karma'
require_relative '../plugins/lunchroulette'
require_relative '../plugins/thegrads'
require_relative '../plugins/tube'
require_relative '../plugins/weather'

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
