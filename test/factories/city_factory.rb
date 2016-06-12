FactoryGirl.define do

  factory :city do
    sequence(:name)      { |n| "City ##{n}" }
    latitude  0
    longitude 0
  end

end
