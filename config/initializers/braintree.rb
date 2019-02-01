
environment = Rails.env.production? ? :production : :sandbox

Braintree::Configuration.environment = environment
Braintree::Configuration.merchant_id = Rails.application.credentials.dig :braintree, environment, :merchant_id
Braintree::Configuration.public_key  = Rails.application.credentials.dig :braintree, environment, :public_key
Braintree::Configuration.private_key = Rails.application.credentials.dig :braintree, environment, :private_key
