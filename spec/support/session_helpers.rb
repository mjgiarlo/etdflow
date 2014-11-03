module Features
  module SessionHelpers
    def sign_in(who = :author)
      author = who.is_a?(Author) ? who : FactoryGirl.find_or_create(who)
      driver_name = "rack_test_authenticated_header_#{author.access_id}".to_s
      Capybara.register_driver(driver_name) do |app|
        Capybara::RackTest::Driver.new(app,
          respect_data_method: true,
          headers: { 'REMOTE_USER' => author.access_id })
      end
      Capybara.current_driver = driver_name
    end
  end
end
