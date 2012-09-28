require 'spec_helper'

describe GoogleClient do
  before(:each) do
    @config = double('config').as_null_object
    @message = double('message').as_null_object
  end
  
  it "should return the number of results for a query" do
    response = '{"responseData":{"cursor":{"estimatedResultCount": "100"}}}'
    RestClient.stub(:get).and_return(response)
    GoogleClient.get_result_count('foo').should equal 100
  end
end
