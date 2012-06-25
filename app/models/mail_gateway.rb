class MailGateway

  cattr_accessor :gateway

  def self.method_missing(method_name, *args, &block)
    if gateway.respond_to?(method_name)
      gateway.send(method_name, *args, &block)
    else
      raise NotImplementedError
    end
  end

end