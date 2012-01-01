require 'spec_helper'

describe SupportController do

	it "should show new" do
		get :new
		response.should be_success
	end

	it "should allow creation of new support tickets" do
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

end
