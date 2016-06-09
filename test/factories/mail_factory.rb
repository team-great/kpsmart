FactoryGirl.define do

  factory :mail, class: "MailDelivery" do
    association :to, factory: :city, name: 'Wellington'
    association :from, factory: :city, name: 'Auckland'
    weight 1
    volume 1
    day 'Monday'
    priority 'Air'
  end

end
