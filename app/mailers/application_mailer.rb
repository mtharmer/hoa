# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: Rails.configuration.x.mail_from || 'no-reply@localhost'
  layout 'mailer'
end
