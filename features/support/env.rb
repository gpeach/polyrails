ENV['RAILS_ENV'] = 'test'
require './config/environment'

#require "webmock"
#include WebMock::API
#WebMock.disable_net_connect!(allow_localhost: true)


require "spinach/capybara"
require "capybara-screenshot/spinach"
require 'capybara/rails'
require 'selenium-webdriver'
require 'rspec-rails'
require 'spinach/frameworks/rspec'

#require "ci/reporter/spinach"

#Dir[Rails.root.join("features/support/**/*.rb")].each do |f|
#  require f
#end
#
#require Rails.root.join("features/steps/common_steps/base")
Capybara::Screenshot.register_driver(:chrome) do |driver, path|
  driver.browser.save_screenshot(path)
end

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.javascript_driver = :chrome
#Capybara.javascript_driver = :webkit
#Capybara.javascript_driver = :selenium

Capybara.default_max_wait_time = (ENV["CAPYBARA_WAIT_TIME"] || 15).to_i
Capybara.wait_on_first_by_default = true
Capybara.default_selector = :css

  Capybara::Webkit.configure do |config|
    #config.debug = true
    config.allow_unknown_urls
    #config.allow_url("fonts.googleapis.com")
    #config.allow_url("www.cannabisreports.com")
  end

require "database_cleaner"

Spinach.hooks.before_run do
  DatabaseCleaner.clean_with(:truncation)
end

Spinach.hooks.on_tag("javascript") do
  ::Capybara.current_driver = ::Capybara.javascript_driver
end

Spinach.hooks.before_scenario do
  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.start
end

Spinach.hooks.after_scenario do
  DatabaseCleaner.clean
  `rm -rf ~/.mozilla`
end
