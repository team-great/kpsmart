require 'routing/graph'
require 'timecalc/timecalc'

class MailDelivery < ActiveRecord::Base
  include RoutesHelper
  include Timecalc
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

  def routes_ordered
    sorted = []
    todo = routes.to_ary
    last = from

    while !todo.empty?
      index = todo.index do |t|
        t.from.id == last.id
      end
      if index.nil?
        byebug
      else
        route = todo.delete_at(index)
        sorted << route
        last = route.to
      end
    end

    sorted
  end

  # business facing cost
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

  def duration
    time = created_at.utc
    total = 0

    routes.each do |route|
      next_del, wait = next_del_time route.frequency, time

      total += wait + route.duration
      time = next_del + wait.hours
    end

    total.to_f
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
    end

    if from_name

      from_id = City.get_id_from_name(from_name)
      if from_id
        self.from_id = from_id
      else
        errors.add(:from_name, "#{from_name.capitalize} is not a valid city")
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

  def set_day

    self.day = Time.now.strftime('%A').downcase

  end


  def create_path

    if self.to.nil?
      errors.add(:to, "must have a destination")
    end
    if self.from.nil?
      errors.add(:from, "must have a source")
    end
    return if errors.any?

    results = get_route self.from.name, self.to.name

    if !results.valid
      errors.add("Unable to find a route between '#{self.from.name}' and '#{self.to.name}'.")
    end

  end
end
