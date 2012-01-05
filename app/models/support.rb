class Support < ActiveRecord::Base

	after_create :send_emails

	validates_presence_of :name
	validates :email, format: {
	  with: /(\A[^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
	  on: :create }
	validates :support, length: { :minimum => 10 }


	def send_emails
		SupportMailer.confirm_email(self).deliver
	end

	cattr_accessor :configuration
	class << self

		#this method is used to access the supporty configuration
		# file. returns the whole hash if no attribute given,
		# otherwise, returns the requested value and falls back to nil
		def config(attr = nil)
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
	end
end
