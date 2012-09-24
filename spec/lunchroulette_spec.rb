require_relative '../plugins/lunchroulette'
require 'spec_helper'

describe LunchRoulette do
  before(:each) do
    @config = double('config').as_null_object
    @message = double('message').as_null_object
    @plugin = LunchRoulette.new(@config)
    @harness = TestHarness.new(@plugin)
  end
  
  it "should match lunch messages" do
    @harness.match?('lunchroulette test').should be true
  end
  
  it "should not match empty lunch messages" do
    @harness.match?('lunchroulette').should be false
  end
  
  it "should reply for places it knows about" do
    @message.should_receive(:reply)
    @plugin.execute(@message, 'w1')
  end
  
  it "should apologise for places it does not know about" do
    @message.should_receive(:reply).with(/sorry/)
    @plugin.execute(@message, 'guatemala')
  end
end
