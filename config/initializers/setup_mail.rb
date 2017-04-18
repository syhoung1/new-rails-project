# ActionMailer::Base.smtp_settings = {
#   :port           => ENV['MAILGUN_SMTP_PORT'],
#   :address        => ENV['MAILGUN_SMTP_SERVER'],
#   :user_name      => ENV['MAILGUN_SMTP_LOGIN'],
#   :password       => ENV['MAILGUN_SMTP_PASSWORD'],
#   :domain         => 'tranquil-beyond-98006.herokuapp.com',
#   :authentication => :plain,
# }
# ActionMailer::Base.delivery_method = :smtp

if Rails.env.development? || Rails.env.production?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    address: 'smtp.sendgrid.net',
    port: '2525',
    authentication: :plain,
    user_name: ENV['SENDGRID_NAME'],
    password: ENV['SENDGRID_PASSWORD'],
    domain: 'heroku.com',
    enable_starttls_auto: true
  }
end