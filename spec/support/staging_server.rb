Capybara.default_driver = :poltergeist
Capybara.app = :remote
Capybara.app_host = 'http://staging.etdflow.westarete.com'
puts "Running tests against #{Capybara.app_host}"