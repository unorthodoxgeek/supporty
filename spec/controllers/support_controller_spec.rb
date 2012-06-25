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

end
