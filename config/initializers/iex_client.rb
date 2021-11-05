IEX::Api.configure do |config|
    # TODO: place credentials in credentials.yml.enc
    config.publishable_token = Rails.application.credentials.iex[:publishable_token]
    config.secret_token = Rails.application.credentials.iex[:secret_token]
    config.endpoint = 'https://cloud.iexapis.com/v1' # use 'https://sandbox.iexapis.com/v1' for Sandbox
end