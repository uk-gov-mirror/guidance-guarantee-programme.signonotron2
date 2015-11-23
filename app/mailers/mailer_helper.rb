module MailerHelper
  def email_from
    "#{app_name} <#{email_from_address}>"
  end

  def app_name
    if instance_name.present?
      "Pension Wise Signon #{instance_name}"
    else
      "Pension Wise Signon"
    end
  end

  def email_from_address
    if instance_name.present?
      "noreply-signon-#{instance_name.parameterize}@pensionwise.gov.uk"
    else
      "noreply-signon@pensionwise.gov.uk"
    end
  end

  def instance_name
    Rails.application.config.instance_name
  end
end
