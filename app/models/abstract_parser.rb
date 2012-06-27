
# AbstractParser is an abstract class which defines the api for parsing
# incoming emails for new support tickets or replies to existing tickets
# The inheriting classes would create or add new data to support tickets
# using different APIs, allowing communication with different SAAS providers

class AbstractParser

  #each parser can take in the handle! class method, which simply
  #creates a new instance of parser using the params hash
  def self.handle!(params = {})
    self.new(params)
  end

  def self.update_ticket(data = {})
    if data[:ticket_id].present? && (ticket = Support.find(data[:ticket_id])).present?
      data[:support_id] = ticket.id
      data.delete(:ticket_id)
      ticket.add_response!(data)
    else
      ticket = Support.create_from_mail!(data)
    end

  end

  def self.get_reply_body(email_body)
    email_body_arr = email_body.split("-- REPLY ABOVE THIS LINE --")
    email_body_arr[0] 
  end

  def subject
    raise NotImplementedError
  end

  def from_email
    raise NotImplementedError
  end

  def from_name
    raise NotImplementedError
  end

  def to
    raise NotImplementedError
  end

  def body
    raise NotImplementedError
  end

  def ticket_id
    raise NotImplementedError
  end

end