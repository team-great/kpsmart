FactoryGirl.define do

  factory :city do
    name      { |n| "City ##{n.hash}" }
    latitude  0
    longitude 0
  end

end
