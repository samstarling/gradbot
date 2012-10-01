require 'spec_helper'

describe TheGrads do
  before(:each) do
    config = double('config').as_null_object
    config.stub(:nick).and_return('gradbot')
    @message = double('message')
    @channel = double('channel')
    @user = double('user')
    @message.stub(:channel).and_return(@channel)
    @message.stub(:user).and_return(@user)
    @user.stub(:nick).and_return('gradbot')
    @plugin = TheGrads.new(config)
  end
  
  it "should change the topic, then let anyone change the topic" do
    user = double('user')
    @channel.should_receive(:topic=).with('The Grads')
    @channel.should_receive(:mode).with('-t')
    @plugin.listen(@message)
  end
end