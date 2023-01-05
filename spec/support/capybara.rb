require "capybara/rails"
require "capybara/rspec"
require "capybara-screenshot/rspec"
require "selenium/webdriver"

Capybara.register_driver :selenium_chrome_headless_in_container do |app|
  Capybara::Selenium::Driver.new app,
    browser: :remote,
    url: "http://selenium_chrome:4444/wd/hub",
    capabilities: [Selenium::WebDriver::Remote::Capabilities.chrome(
      "goog:chromeOptions" => {
        "args" => %w[headless disable-gpu window-size=1280,900],
        "prefs" => {
          "download.prompt_for_download" => false,
          "download.default_directory" => "/home/seluser/Downloads",
          "browser.set_download_behavior" => { "behavior" => "allow" },
        },
      }
    )]
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium_chrome_headless_in_container
    Capybara.server_host = "0.0.0.0"
    Capybara.server_port = 4000
    Capybara.app_host = "http://web:4000"
  end
end
