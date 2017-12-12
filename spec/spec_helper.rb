require 'rubygems'
require 'database_cleaner'
require 'capybara/rspec'
require 'webmock/rspec'
require 'paperclip/matchers'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'devise'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
Dir[Rails.root.join('spec/shared_contexts/**/*.rb')].each { |f| require f }
Dir[Rails.root.join('spec/shared_examples/**/*.rb')].each { |f| require f }
Dir[Rails.root.join('spec/support/macros/*.rb')].each { |f| require f }

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.include AbstractController::Translation
  config.include Rails.application.routes.url_helpers

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.include Capybara::DSL
  config.after(:suite) do
    FileUtils.rm_rf(Dir["#{Rails.root}/tmp/paperclip/"])
  end
  config.include Paperclip::Shoulda::Matchers
  config.before(:each) do
    stub_request(:get, /admin.paysale.com/).to_return(body: 'OK', status: 200)
  end
end
