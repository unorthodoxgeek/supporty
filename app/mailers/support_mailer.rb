class SupportMailer < ActionMailer::Base
  default from: Support.config("send_mail_from")

  def confirm_email(ticket)
  	@ticket = ticket
  	mail(
      :to =>ticket.email,
      :subject => t("supporty.emails.confirm.title")
    )
  end

end
