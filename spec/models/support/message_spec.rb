require 'spec_helper'

describe Support::Message do
  describe "emails" do
    before :all do
      @ticket = Factory.create(:ticket)
    end

    it "should send email to the user on reply from agent" do
      lambda {
        Factory.create(:ticket_message, :support_id => @ticket.id, :agent => true)
      }.should change(ActionMailer::Base.deliveries, :size).by(1)
    end

    it "should not send email to the user on reply from user" do
      lambda {
        Factory.create(:ticket_message, :support_id => @ticket.id, :agent => false)
      }.should_not change(ActionMailer::Base.deliveries, :size)
    end

  end
end
