# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  user_name: ENV.fetch("SMTP_USER") { 'api_key' },
  password: ENV.fetch("SMTP_PASSWORD") { '' },
  domain: ENV.fetch("SMTP_DOMAIN") { 'thecovrigs.com' },
  address: ENV.fetch("SMTP_ADDRESS") { 'smtp.sendgrid.net' },
  port: ENV.fetch("SMTP_PORT") { 587 },
  authentication: :plain,
  enable_starttls_auto: true
}
