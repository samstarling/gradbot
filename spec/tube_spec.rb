require 'spec_helper'

describe TubeStatus do
  before(:each) do
    config = double('config').as_null_object
    @plugin = TubeStatus.new(config)
    @harness = TestHarness.new(@plugin)
    @message = double('message')
  end

  it "should reply to messages" do
    @message.should_receive(:reply).at_least(1).times
    @plugin.execute(@message)
  end

  it "should reply to generic tube requests" do
    @harness.match?('!tube').should be true
  end

  it "should reply to requests for a specific line" do
    @harness.match?('!tube central').should be true
  end

  it "should respond with the status of known lines" do
    RestClient.stub(:get).and_return(load_fixture('valid-tube.json'))
    @message.should_receive(:reply).with(/good service/i).at_most(1).times
    @plugin.execute(@message, 'foo')
  end

  it "should respond appropriately for unknown lines" do
    RestClient.stub(:get).and_return(load_fixture('invalid-tube.json'))
    @message.should_receive(:reply).with(/unrecognised lines value/i)
    @plugin.execute(@message, 'foo')
  end

  it "should report epic failures" do
    RestClient.stub(:get).and_return(load_fixture('totally-invalid-tube.json'))
    @message.should_receive(:reply).with(/epic tube fail/i)
    @plugin.execute(@message, 'foo')
  end

  it "should not reply to messages that don't contain tube" do
    @harness.match?('i was on the tube').should be false
  end
end