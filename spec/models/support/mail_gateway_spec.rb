require 'spec_helper'

describe Support::MailGateway do

  it "should be able to define a gateway" do
    lambda {
      Support::MailGateway.gateway = Support::PostmarkParser
      }.should_not raise_error
    
    Support::MailGateway.gateway.should == Support::PostmarkParser
  end

  it "should raise NotImplemented error in case of passing unknown method" do
    Support::MailGateway.gateway = Support::PostmarkParser
    lambda {
      Support::MailGateway.foo
      }.should raise_error(NotImplementedError)
  end

  it "should correctly pass methods to the gateway" do
    Support::MailGateway.gateway = Support::PostmarkParser
    Support::PostmarkParser.should_receive(:foo).with(:a,:b,:c).and_return(nil)

    Support::MailGateway.foo(:a,:b,:c)
  end

end