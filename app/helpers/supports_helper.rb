module SupportsHelper

  def support_user
    self.send(Support.config["user_method"])
  end

  def support_admin?
    support_user.send(Support.config["admin_method"])
  end

  def support_agent?
    support_user.send(Support.config["agent_method"])
  end

end
