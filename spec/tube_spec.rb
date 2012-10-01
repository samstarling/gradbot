require 'spec_helper'

describe TubeStatus do
  before(:each) do
    config = double('config').as_null_object
    @plugin = TubeStatus.new(config)
    @harness = TestHarness.new(@plugin)
    @message = double('message')
  end

  it "should reply to !tube" do
    @harness.match?('!tube').should be true
  end
  
  it "should not reply to messages that don't contain tube" do
    @harness.match?('i was on the tube').should be false
  end

  it "should reply to messages" do
    @message.should_receive(:reply).at_least(1).times
    @plugin.execute(@message)
  end
end