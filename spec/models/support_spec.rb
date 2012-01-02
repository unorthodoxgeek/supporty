require 'spec_helper'

describe Support do

  describe "configuration file" do

  	it "should return a hash" do
  		Support.config.is_a?(Hash).should be_true
  	end

  	it "should return valid attribute" do
  		Support.config("success_redirect_path").should_not be_blank
  	end

  	it "should not raise exception if invalid attribute passed" do
  		Support.config("wagabolama").should be_nil
  	end

  end

  describe "opening a ticket" do

  	it "should open a ticket given valid attrubutes" do
  		@ticket = Support.new(Factory.attributes_for(:ticket))
  		@ticket.should be_valid
  	end

  	it "should send email to the user one ticket is opened" do
  		lambda {
  			Factory.create(:ticket)
  		}.should change(ActionMailer::Base.deliveries, :size).by(1)
  	end

  end

end
