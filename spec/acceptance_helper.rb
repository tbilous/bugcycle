require 'rails_helper'
require 'rack_session_access/capybara'
require 'puma'
require 'capybara/email/rspec'
require 'i18n'
require 'capybara/webkit'


RSpec.configure do |config|
  include ActionView::RecordIdentifier
  config.include AcceptanceHelper, type: :feature
  config.include FeatureMacros, type: :feature
  # OmniAuth.config.test_mode = true
  # config.before(:each, type: :feature) do
  #   default_url_options[:locale] = I18n.default_locale
  # end
  #
  Capybara.server_host = 'localhost'
  Capybara.server_port = 5000 + ENV['TEST_ENV_NUMBER'].to_i
  Capybara.default_max_wait_time = 2
  Capybara.save_path = './tmp/capybara_output'
  Capybara.always_include_port = true # for correct app_host

  Capybara.javascript_driver = :webkit

  # Capybara::Webkit.configure do |webkit|
  #   webkit.allow_url('10.0.2.15')
  #   webkit.allow_url('fonts.googleapis.com')
  #   webkit.allow_url('maxcdn.bootstrapcdn.com')
  # end

  Capybara.server = :puma

  config.use_transactional_fixtures = false

  config.before(:suite) { DatabaseCleaner.clean_with :truncation }

  config.before(:each) { DatabaseCleaner.strategy = :transaction }

  config.before(:each, js: true) { DatabaseCleaner.strategy = :truncation }

  # config.before(:each, type: :feature) { Capybara.app_host = "http://dev.#{Capybara.server_host}.xip.io" }

  config.before(:each) { DatabaseCleaner.start }

  config.after(:each) { Timecop.return }

  config.append_after(:each) do
    # Capybara.reset_sessions!
    DatabaseCleaner.clean
  end
end
