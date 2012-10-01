require 'spec_helper'

describe Weather do
  before(:each) do
    config = double('config').as_null_object
    @plugin = Weather.new(config)
    @harness = TestHarness.new(@plugin)
    @message = double('message').as_null_object
  end

  it "should match !weather {arg}" do
    @harness.match?('!weather salford').should be true
  end

  it "should reply to messages" do
    @message.should_receive(:reply).at_least(1).times
    @plugin.execute(@message, 'foo')
  end

  it "should apologise for places it doesn't know about" do
  end

  it "should provide the weather for places it does know about" do
  end

  it "should convert farenheit to celcius" do
  end
end