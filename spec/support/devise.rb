# spec/support/devise.rb
require 'devise'
require 'warden'

module DeviseRequestSpecHelpers
  include Warden::Test::Helpers

  def login_provider(provider)
    login_as(provider, scope: :provider)
  end

  def logout_provider
    logout(:provider)
  end
end

RSpec.configure do |config|
  # Request spec helpers
  config.include DeviseRequestSpecHelpers, type: :request
  config.include Devise::Test::IntegrationHelpers, type: :request
  
  # Controller spec helpers (if you still need them)
  config.include Devise::Test::ControllerHelpers, type: :controller

  config.before(:suite) do
    Warden.test_mode!
  end

  config.after(:each) do
    Warden.test_reset!
  end
end