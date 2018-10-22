class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@rezept.herokuapp.com'
  layout 'mailer'
end
