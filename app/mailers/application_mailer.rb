class ApplicationMailer < ActionMailer::Base
  default from: "#{t('app_name')} <hello@climbin.co.uk>"
  layout 'mailer'
end
