ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"
require "./test/support/shoulda"

module ActiveSupport
  class TestCase
    include FactoryBot::Syntax::Methods

    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    # fixtures :all

    # Add more helper methods to be used by all tests here...

    def client_headers
      { "PushBox-Api-Key": client_api_key }.as_json
    end

    def admin_headers
      { "PushBox-Api-Key": admin_api_key }.as_json
    end

    def device_headers(device)
      {
        "PushBox-Device-Api-Key": device.api_key,
        "PushBox-Api-Key": client_api_key
      }.as_json
    end

    def admin_api_key
      @user_admin ||= User.create(name: 'user_admin', role: :admin)
      @user_admin.api_key
    end

    def client_api_key
      @user_client ||= User.create(name: 'user_client', role: :client)
      @user_client.api_key
    end

    def json
      @response.parsed_body
    end
  end
end
