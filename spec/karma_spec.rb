require 'spec_helper'

describe Karma do
  before(:each) do
    @config = double('config').as_null_object
    @message = double('message').as_null_object
    @karma = Karma.new(@config)
    @karma.startup
    @karma.reset_karma
  end
  
  it "should add karma to something" do
    @karma.add_karma(@message, 'cats')
    @karma.get_value(:cats).should == 1
  end
  
  it "should remove karma from something" do
    @karma.remove_karma(@message, 'dogs')
    @karma.get_value(:dogs).should == -1
  end
  
  it "should persist the karma" do
    @karma.add_karma(@message, 'houmous')
    @karma = Karma.new(@config)
    @karma.startup
    @karma.add_karma(@message, 'houmous')
    @karma.get_value(:houmous).should == 2
  end
  
  it "should reply with the karma things have" do
    @karma.add_karma(@message, 'ruby')
    @message.should_receive(:reply).with('ruby has 1 karma')
    @karma.execute(@message)
  end
  
  it "should not reply for things that have no karma" do
    @karma.add_karma(@message, 'baby_jesus')
    @karma.remove_karma(@message, 'baby_jesus')
    @message.should_not_receive(:reply)
    @karma.execute(@message)
  end
  
  it "should be case insensitive" do
    @karma.add_karma(@message, 'cats')
    @karma.add_karma(@message, 'CATS')
    @karma.get_value(:cats).should == 2
  end

  it "should sort things in descending karma order" do
    @karma.add_karma(@message, 'python')
    @karma.add_karma(@message, 'python')
    @karma.add_karma(@message, 'ruby')
    @karma.add_karma(@message, 'ruby')
    @karma.add_karma(@message, 'ruby')
    @karma.add_karma(@message, 'java')
    @message.should_receive(:reply).with('ruby has 3 karma')
    @message.should_receive(:reply).with('python has 2 karma')
    @message.should_receive(:reply).with('java has 1 karma')
    @karma.execute(@message)
  end

  it "conflates things with the same karma score" do
    @karma.add_karma(@message, 'cats')
    @karma.add_karma(@message, 'dogs')
    @message.should_receive(:reply).with('cats and dogs have 1 karma')
    @karma.execute(@message)
  end
end
