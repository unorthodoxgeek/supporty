# This class parses the json string recieved from the postmark
# service, via an http call. The json represents all the date regarding

class Support::PostmarkParser < AbstractParser

  def initialize(json)
    @source = json
    reply_body = Support::PostmarkParser.get_reply_body(body)
    params = {
      body: reply_body,
      subject: subject,
      from_email: from_email,
      from_name: from_name,
      ticket_id: ticket_id
    }
    Support::PostmarkParser.update_ticket(params)
  end

  attr_reader :source

#prototype methods

  def subject
    source["Subject"]
  end

  def from_email
    if match = from.match(/^.+<(.+)>$/)
      match[1].strip
    else
      from
    end
  end

  def from_name
    if match = from.match(/(^.+)<.+>$/)
      match[1].strip
    else
      from
    end
  end

  def to
    source["To"]
  end

  def body
    html_body || text_body
  end

  def ticket_id
    Support::PostmarkParser.get_email_hash_data(mailbox_hash)
  end

# custom methods

  #This method assumes there's only a ticket id, but point is, we might
  #want to store more data in the future, so why not prepare for it?
  def self.get_email_hash_data(email_hash)
    hashed_arr = email_hash.split("-")
    {
      ticket_id: hashed_arr[0]
    }
  end

  def from
    source["From"].gsub('"', '')
  end

  def bcc
    source["Bcc"]
  end

  def cc
    source["Cc"]
  end

  def reply_to
    source["ReplyTo"]
  end

  def html_body
    source["HtmlBody"]
  end

  def text_body
    source["TextBody"]
  end

  def mailbox_hash
    source["MailboxHash"]
  end

  def tag
    source["Tag"]
  end

  def headers
    @headers ||= source["Headers"].inject({}){|hash,obj| hash[obj["Name"]] = obj["Value"]; hash}
  end

  def message_id
    source["MessageID"]
  end

end