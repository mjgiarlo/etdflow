 def basic_auth_and_visit(path)
   basic_auth 
   visit path
 end

 def basic_auth  #(access_id="etdflow", pass="fold wet")
#   # if page.driver.browser.respond_to?(:basic_authorize)
#   #   # Normal capybara driver
#   #   page.driver.browser.basic_authorize(user,pass)
#   # else
#   #   # Poltergeist
#   #   page.driver.basic_authorize(user, pass)
#   # end
    sign_in_as author
 end
