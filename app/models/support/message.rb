class Support::Message < ActiveRecord::Base
#associations
  belongs_to :support

#callbacks

  after_create :touch_ticket, :send_email

#attributes

#scopes
  scope :customer_reply, where(agent: false)
  scope :agent_reply, where(agent: true)

#class methods

#instance methods
  
  def touch_ticket
    support.touch
  end

  def send_email
    if agent_reply?
      SupportMailer.ticket_updated(support, self).deliver
      #TODO: send email to agent if defined
    end
  end

  def agent_reply?
    agent?
  end

  def ticket
    support
  end
end
