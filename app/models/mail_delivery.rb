class MailDelivery < ActiveRecord::Base
  has_and_belongs_to_many :routes
  #represents a single peice of mail traveling through the system
  attr_accessor :to_name, :from_name, :priority_name


  before_validation(on: [:create, :update]) do

    convert_node_names_to_ids
    convert_priority_to_int

  end

  private

  def convert_node_names_to_ids

    self.to_id = City.get_id_from_name(to_name)
    self.from_id = City.get_id_from_name(from_name)

  end

  def convert_priority_to_int

    types = {

        'Air' => 0,
        'Sea' => 1

    }
    
    self.priority = types[priority_name]

  end

end
