# README

Instructions for iex-API 
- Add "gem 'iex-ruby-client' " to Gemfile
- Run bundle install 
- Add "gem 'dotenv-rails', groups: [:development, :test]" to Gemfile as well
- Run bundle
- Create an account on IEX Cloud to get a publishable and secret token from the IEX Cloud 
- Create a .env file to store both tokens
- Add .env to git ignore to hide tokens 
- https://github.com/dblock/iex-ruby-client --> Get information about stocks from here 
- Create a private method
    def client 
      IEX::Api::Client.new(
        publishable_token: ENV['PUBLISHABLE_TOKEN'],
        secret_token: ENV['SECRET_TOKEN'],
        endpoint: 'https://cloud.iexapis.com/v1'
      )
    end
- Add "before_action :client, only: [:index, :create, :search]"
- Create method
  def index
    @quote = client.quote('TSLA')
  end
- Add to your views 
