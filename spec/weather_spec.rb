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
end