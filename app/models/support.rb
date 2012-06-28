class Support < ActiveRecord::Base

#associations
  has_many :messages, class_name: "Support::Message"

#callbacks
  after_create :send_emails

#validations
  validates_presence_of :name
  validates :email, format: {
    with: /(\A[^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
    on: :create }
  validates :support, length: { :minimum => 10 }, :unless => :created_from_mail?

#attributes
  cattr_accessor :configuration
  serialize :meta_fields, Hash

#class_methods

  #this method is used to access the supporty configuration
  # file. returns the whole hash if no attribute given,
  # otherwise, returns the requested value and falls back to nil
  def Support.config(attr = nil)
    if @configuration.blank?
      yaml = YAML.load(File.open("#{Rails.root}/config/supporty.yml"))
      if yaml.has_key?(Rails.env)
        @configuration = yaml[Rails.env]
      else
        raise "There's no configuration for the rails environment you're using"
      end
    end
    return @configuration if attr.blank?
    return @configuration[attr]
  end

  def Support.create_from_mail!(data={})
    valid_attributes = [:body, :subject, :from_email, :from_name, :ticket_id]
    data.symbolize_keys!
    data.assert_valid_keys(*valid_attributes)

    params = {
      reason: data[:subject],
      name: data[:from_name],
      email: data[:from_email],
      support: data[:body]
    }

    ticket = Support.new(params)
    ticket.created_from_mail!
    ticket.save!
  end

#instance methods
  def send_emails
    SupportMailer.confirm_email(self).deliver
  end

  def add_response!(data)
    messages.create(data)
  end

  def created_from_mail!
    @created_from_mail = true
  end

  def created_from_mail?
    return @created_from_mail
  end

end
