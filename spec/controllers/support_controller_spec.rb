require 'spec_helper'

describe SupportController do
  before :each do
    controller.stub!(:current_user).and_return(nil)
  end

  it "should redirect to new when trying to view index not logged in" do
    get :index
    response.should be_redirect
    response.should redirect_to new_support_path
  end
  
  it "should show new" do
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

  it "should be able to use methods defined in support helper" do
    controller.stub!(:current_user).and_return(1)
    get :new
    response.should be_success
  end

  it "should not allow not logged in user to view tickets" do
    get :show, :id => 1
    response.should be_redirect
  end

  describe "logged in as customer" do

    before :each do
      #we don't have a user model, but it doesn't really matter
      @user = Support.new
      @user.stub!(:id).and_return(1)
      @user.stub(:admin?).and_return(false)
      @user.stub(:agent?).and_return(false)
      controller.stub!(:current_user).and_return(@user)
    end

    it "should return the user's open tickets when viewing index" do
      t=Factory.create(:ticket, :user_id => @user.id)
      get :index
      assigns(:tickets).should == [t]
    end

    it "should not show the user's closed tickets" do
      t=Factory.create(:ticket, :user_id => @user.id)
      t2=Factory.create(:ticket, :user_id => @user.id, :status => "closed")
      get :index
      assigns(:tickets).should == [t]
    end

    it "should let the customer view his tickets" do
      t=Factory.create(:ticket, :user_id => @user.id)
      get :show, :id => t.id
      response.should be_success
      assigns[:ticket].should == t
    end

    it "should not let the customer view his tickets" do
      t=Factory.create(:ticket, :user_id => @user.id+1)
      get :show, :id => t.id
      response.should be_redirect
      response.should redirect_to support_index_path
    end

  end

  describe "logged in agent" do
    before :each do
      #we don't have a user model, but it doesn't really matter
      @user = Support.new
      @user.stub!(:id).and_return(1)
      @user.stub(:admin?).and_return(false)
      @user.stub(:agent?).and_return(true)
      controller.stub!(:current_user).and_return(@user)
    end

    it "should show the agent all the open tickets not assigned to others" do
      Support.delete_all
      t=Factory.create(:ticket)
      t1=Factory.create(:ticket, :agent_id => @user.id+1)
      t0 = Factory.create(:ticket, :agent_id => @user.id)
      t2=Factory.create(:ticket, :status => "closed")
      get :index
      assigns(:tickets).should == [t0, t]
    end

    it "should allow agent to view tickets" do
      t=Factory.create(:ticket)
      get :show, :id => t.id
      response.should be_success
      assigns[:ticket].should == t
    end

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
