MAIL_DOMAIN = "tre-rs.gov.br"

ActionMailer::Base.smtp_settings, = {
    :address  => "rsmail.tre-rs.gov.br",
    :port  => 25, 
    :domain  => MAIL_DOMAIN,
    :raise_delivery_errors => true,
    :authentication => :login,
    :user_name => "gestorweb",
    :password => "gestorweb99"
}   

ActionMailer::Base.default_charset = "UTF-8" 