
ENV['RAILS_ENV'] ||= 'test'
SimpleCov.start
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

    def json
      @response.parsed_body
    end
  end
end


