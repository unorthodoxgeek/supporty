require 'spec_helper'

describe SupportController do

  it "should show new" do
    controller.stub!(:current_user).and_return(nil)
    get :new
    response.should be_success
  end

  it "should allow creation of new support tickets" do
    @new_ticket = Support.new(email: "john@doe.com", name: "John Doe", support: "bla bla bla")
    Support.should_receive(:new).and_return @new_ticket
    @new_ticket.should_receive(:save).and_return(true)
    post :create, support: { email: "john@doe.com", name: "John Doe", support: "bla bla bla" }
    response.should be_redirect
    response.should redirect_to root_path
  end

  it "should allow viewing of support tickets" do
    @ticket = Support.new
    @ticket.stub!(:id).and_return(1)
    Support.stub!(:find).with("1").and_return(@ticket)
    get :show, :id => @ticket.id
    assigns[:ticket].should == @ticket
  end

  it "should be able to use methods defined in support helper" do
    controller.stub!(:current_user).and_return(1)
    get :new
    response.should be_success
  end

  describe "incoming emails gateway" do
    #the current implementation assumes using SAAS for parsing of emails
    #we will use the default bundled gateway of Postmark, but we can
    #easily extend the gem to use different providers.
    
    before :all do
      #make sure that the gateway is the postmark gateway
      Support::MailGateway.gateway = Support::PostmarkParser
      @ticket = Factory.create(:ticket)
      @params = {
        "Subject" => "bla bla bla",
        "From" => "John <john@doe.com>",
        "TextBody" => "bla bla bla pitput shmitput",
        "MailboxHash" => @ticket.id
      }
    end

    it "should successfully get add message to ticket using correct parameters" do
      lambda {
        post :gateway, @params
      }.should change(Support::Message, :count).by(1)
    end

    it "should successfully create a new ticket when no ticket id" do
      @params.delete("MailboxHash")
      lambda {
        post :gateway, @params
      }.should change(Support, :count).by(1)
    end

  end

end
