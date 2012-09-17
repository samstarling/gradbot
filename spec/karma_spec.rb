require_relative '../plugins/karma.rb'

describe Karma do
  
  before(:each) do
    config = double('config').as_null_object
    @karma = Karma.new(config)
    @message = double('message')
  end
  
  it "should add karma to something" do
    @karma.add(@message, 'cats')
  end
  
end