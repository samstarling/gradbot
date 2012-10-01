require 'spec_helper'

describe CelebTracker do
  before(:each) do
    @config = double('config').as_null_object
    @message = double('message').as_null_object
    @celeb = CelebTracker.new(@config)
    # @celeb.filepath = '/tmp/celeb'
    # @celeb.reset
  end

  it "should reply to celebrity sightings" do
    # @message.should_receive(:reply).with(/Sam has been seen/)
    # @celeb.register_celeb(@message, 'Sam')
  end

  it "should keep track of celebrity sightings" do
    # @celeb.register_celeb(@message, 'Sam')
    # @message.should_receive(:reply).with(/Sam has been seen/)
    # @celeb.list_leaderboard(@message, 1)
  end

  it "should persist the tracking of celebrity sightings" do
    # nil
  end
end
