FactoryGirl.define do
 factory :user do
   email { random_name + "@test.box" }
 end

 def random_name
   ('a'..'z').to_a.shuffle.join
 end
end
