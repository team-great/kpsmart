class MailDelivery < ActiveRecord::Base
  belongs_to :to, class_name: 'City'
  belongs_to :from, class_name: 'City'
  has_and_belongs_to_many :routes
  #represents a single peice of mail traveling through the system
  attr_accessor :to_name, :from_name, :priority_name


  before_validation(on: [:create, :update]) do

    convert_node_names_to_ids
    convert_priority_to_int

  end

  # busniness facing cost
  def total_cost
    self.routes.inject(0) do |sum, r|
      sum += (self.weight * r.weight_cost) + (self.volume * r.volume_cost)
    end
  end

  # customer facing price
  def total_price
    self.routes.inject(0) do |sum, r|
      sum += (self.weight * r.weight_price) + (self.volume * r.volume_price)
    end
  end

  private

  def convert_node_names_to_ids

    if to_name

      to_id = City.get_id_from_name(to_name)
      if to_id
        self.to_id = to_id
      else
        errors.add(:to_name, "#{to_name} is not a valid city")
      end
    end

    if from_name

      from_id = City.get_id_from_name(from_name)
      if from_id
        self.from_id = from_id
      else
        errors.add(:from_name, "#{from_name} is not a valid city")
      end
    end

  end

  def convert_priority_to_int

    types = {
      'Air' => 1,
      'Sea' => 2
    }

    # stop priority from getting nilled by missing priority_name
    if priority_name
      priority_id = types[priority_name]

      # ensure we are using a valid priority
      if priority_id
        self.priority = priority_id
      else
        errors.add(:priority_name, "#{priority_name} is not a valid priority")
      end
    end

  end


end
