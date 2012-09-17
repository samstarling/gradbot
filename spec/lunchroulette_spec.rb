require_relative '../plugins/lunchroulette.rb'
require 'rest-client'

describe LunchRoulette do
  before(:each) do
    config = double('config').as_null_object
    @lunch = LunchRoulette.new(config)
    @message = double('message')
    user = double('user')
    user.stub(:nick).and_return('Boris')
    @message.stub(:user).and_return(user)
  end

  it "should pick a venue" do
    @message.should_receive(:reply)
    @lunch.execute(@message, 'w12')
  end
end