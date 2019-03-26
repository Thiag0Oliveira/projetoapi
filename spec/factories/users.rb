FactoryBot.define do

 factory :user do
  
   email {Faker::Internet.email}#{"contato.tgh@hotmail.com"}
   password  { '123456' }
   password_confirmation  {'123456' } 
   #encrypted_password {'123456'}
  #  password_confirmation "123456"
  end
end

##FactoryBot.define do
 # factory :user do
  #  email  {"contato.tgh@hotmail.com"} 
 #   password  {"123456" }
  #  password_confirmation  {"123456"} 
     
 # end
#end
#end