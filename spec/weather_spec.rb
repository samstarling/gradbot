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

  it "should apologise for places it doesn't know about" do
    @message.should_receive(:reply).with(/sorry/i)
    @plugin.execute(@message, 'foo')
  end

  it "should provide the weather for places it does know about" do
    RestClient.stub(:get).and_return(load_fixture('weather.json'))
    @message.should_receive(:reply).with(/Light Rain Shower/)
    @plugin.execute(@message, 'london')
  end

  it "should convert farenheit to celcius" do
    RestClient.stub(:get).and_return(load_fixture('weather.json'))
    @message.should_receive(:reply).with(/27C/)
    @plugin.execute(@message, 'london')
  end
end