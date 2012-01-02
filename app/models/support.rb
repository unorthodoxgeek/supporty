class Support < ActiveRecord::Base
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
