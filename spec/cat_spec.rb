require_relative '../plugins/cat.rb'
require 'rest-client'

describe Cat do
  before(:each) do
    config = double('config').as_null_object
    @cat = Cat.new(config)
    @message = double('message')
    RestClient.stub(:get).and_return('<url>cat</url>')
  end
  
  it "should reply to messages" do
    @message.should_receive(:reply)
    @cat.execute(@message)
  end
  
  it "should extract images from the cat API" do
    @message.should_receive(:reply).with('cat')
    @cat.execute(@message)
  end
  
  it "shouldn't reply when there's no image" do
    RestClient.stub(:get).and_return('<foo>bar</foo>')
    @message.should_not_receive(:reply)
    @cat.execute(@message)
  end
end