#require 'simplecov'
#require 'rspec'
#SimpleCov.start 'rails'

class TestHarness
  attr_reader :bot
  
  def initialize bot
    @bot = bot
  end
  
  def match msg
    @bot.handlers.each do |h|
      if h.pattern.pattern.match msg
        return h
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
