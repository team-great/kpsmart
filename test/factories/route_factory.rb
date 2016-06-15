FactoryGirl.define do

  factory :route do
    association :to, factory: :city
    association :from, factory: :city
    priority 1
    provider "factory"
    weight_cost 10
    volume_cost 10
    weight_price 5
    volume_price 5
    max_weight 1000
    max_volume 1000
    duration 10
    frequency 5
    day "Monday"
  end

end
