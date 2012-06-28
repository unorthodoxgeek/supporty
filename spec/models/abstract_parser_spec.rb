require 'spec_helper'

describe AbstractParser do
  
  describe "valid data" do
    before :all do
      @params = {
        body: "bla bla bla bla bla",
        subject: "bla bla bla bla bla",
        from_email: "test@support.com",
        from_name: "John",
        ticket_id: nil
      }
    end

    it "should create a new ticket from a new support email" do
      lambda {
        AbstractParser.update_ticket(@params)
        }.should change(Support, :count).by(1)
    end

    it "should create a new ticket from a new support email, even when too short a body" do
      params = @params
      params[:body] = "short"
      lambda {
        AbstractParser.update_ticket(params)
        }.should change(Support, :count).by(1)
    end

    it "should update an existing ticket from a reply email" do
      ticket = Factory.create(:ticket)
      params = @params.merge({ticket_id: ticket.id})

      lambda {
        AbstractParser.update_ticket(params)
      }.should change(Support::Message, :count).by(1)
    end
  end

  describe "not implemented methods" do
    it "should raise NotImplementedError when trying to call placeholders" do
      lambda {
        AbstractParser.new.body
      }.should raise_error(NotImplementedError)
    end
  end
end
