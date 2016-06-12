FactoryGirl.define do

  factory :mail, class: "MailDelivery" do
    association :to, factory: :city
    association :from, factory: :city
    weight 1
    volume 1
    day 'Monday'
    priority 'Air'


    trait :with_route do
      routes { |g|
        [
          g.association(:route, to: self.to, from: self.from)
        ]
      }
    end
  end

end
