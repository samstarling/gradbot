require 'spec_helper'

describe "Metrolink" do

  before(:each) do
    config = double('config').as_null_object
    @plugin = Metrolink.new(config)
    @harness = TestHarness.new(@plugin)
    @message = double('message')
  end

  it "should respond to tram requests" do
    @harness.match?('!tram').should be true
  end

  it "should tell me how the trams are running" do
    RestClient.stub(:get).and_return(load_fixture('metrolinkstatus.html'))
    @message.should_receive(:reply).with(/Normal Service/i)
    @plugin.execute(@message)
  end

end