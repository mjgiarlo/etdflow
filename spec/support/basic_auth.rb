 def basic_auth_and_visit(path)
   basic_auth 
   visit path
 end

 def basic_auth
    sign_in_as author
 end
