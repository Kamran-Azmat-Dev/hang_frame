PayPal::SDK.load("config/paypal.yml",  ENV['RACK_ENV'] || 'production')
PayPal::SDK.logger = Rails.logger
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
