require 'routing/graph'

class MailDelivery < ActiveRecord::Base
  belongs_to :to, class_name: 'City'
  belongs_to :from, class_name: 'City'
  has_and_belongs_to_many :routes
  #represents a single piece of mail traveling through the system
  attr_accessor :to_name, :from_name, :priority_name

  validates :volume, :numericality => { :greater_than => 0, :message => 'Volume must be larger than 0.' }
  validates :weight, :numericality => { :greater_than => 0, :message => 'Weight must be larger than 0.' }



  # prevents updating the package if it has been processed
  before_validation do

    if Time.now > (self.created_at.change(:hour => 17, :min => 0, :sec => 0) rescue Time.now + 1.day)
      self.errors.add(:created_at, 'Unable to update mail item, delivery has already commenced.')
    end

    convert_node_names_to_ids
    convert_priority_to_int

    if !self.errors.any?
      create_path
    end

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
        errors.add(:to_name, "#{to_name.capitalize} is not a valid city")
      end
    else
      errors.add(:to_name, 'Destination is a required field.')
    end

    if from_name

      from_id = City.get_id_from_name(from_name)
      if from_id
        self.from_id = from_id
      else
        errors.add(:from_name, "#{from_name.capitalize} is not a valid city")
      end
    else
      errors.add(:from_name, 'Origin is a required field.')
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
    else
      errors.add(:priority_name, 'The parcels priority must be given.')
    end

  end

  def set_day

    self.day = Time.now.strftime('%A').downcase

  end

  def create_path

    graph = Graph.new
    City.all.each do |city| graph.push(city.id) end

    Route.all.order(from_id: :asc).each do |route|
      graph.connect_mutually route.from_id, route.to_id, route.duration.to_i
    end

    results = graph.dijkstra(self.to_id, self.from_id)

    puts results
    #puts results[:distance]

    if results != nil and results[:distance] > 0
      routes.clear
      results[:path].each do |res|
        self.routes << Route.find_by(id: res)
      end
    else
      errors.add(:to_name, "Unable to find a route between '#{from_name}' and '#{to_name}'.")
    end

  end
end
