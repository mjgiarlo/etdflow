Capybara.default_driver = :poltergeist
Capybara.app = :remote
Capybara.app_host = 'http://etda1qa.dlt.psu.edu'
puts "Running tests against #{Capybara.app_host}"
