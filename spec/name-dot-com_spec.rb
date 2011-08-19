require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "NameDotCom::API" do
  before(:each) do
    @nameDotCom = NameDotCom::API.new
  end

  it "should say hello" do
    @nameDotCom.hello.result.code.should == 100
  end

  it "should check domain availabilty" do
     @nameDotCom.check_domain( :keyword =>"snuffleufegus", :tlds => ["com","org"],:services=>["availablity"] ).domains["snuffleufegus.com"].avail.should == true
     @nameDotCom.check_domain( :keyword =>"google", :tlds => ["com","org"],:services=>["availablity"] ).domains["google.com"].avail.should == false
  end

end

