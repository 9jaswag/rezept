# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@rezept.herokuapp.com'
  layout 'mailer'
end
