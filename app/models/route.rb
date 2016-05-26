class Route < ActiveRecord::Base
  belongs_to :to, class_name: 'City'
  belongs_to :from, class_name: 'City'
  has_and_belongs_to_many :mail_deliveries


  before_validation(on: [:create, :update]) do

    convert_node_names_to_ids
    convert_prority_to_int

  end

  attr_accessor :to_name, :from_name, :priority_name
  has_paper_trail


  validates :to_id, :numericality => {allow_blank: false,
                                      greater_than_or_equal_to: 0,
                                      message: 'Unable to find starting city node for given city name.'
  }, on: :create

  validates :from_id, :numericality => {allow_blank: false,
                                        greater_than_or_equal_to: 0,
                                        message: 'Unable to find destination city node for given city name.'
  }, on: :create

  validates :weight_cost,
            :weight_price,
            :volume_cost,
            :volume_price,
            :max_weight,
            :max_volume,
            :duration,
            :frequency,
            :numericality => {allow_blank: false,
                              greater_than_or_equal_to: 0,
                              :message => Proc.new { |error, attributes|

                                                      "#{attributes[:attribute]} must be 0 or larger."

                              }
  }

  validates :provider, :day, :presence => {

      presence: true,
      :message => Proc.new { |error, attributes|

        "#{attributes[:attribute]} must be present."
      }
  }



  private

  def convert_node_names_to_ids

    # stop to/from ids from getting nilled from missing *_name's
    if to_name
      to_id = City.get_id_from_name(to_name)

      # make sure what you got back is a valid city id
      if to_id
        self.to_id = to_id
      else
        errors.add(:to_name, "#{to_name} is not a valid city")
      end
    end

    if from_name
      from_id = City.get_id_from_name(from_name)

      # make sure what you got back is a valid city id
      if from_id
        self.from_id = from_id
      else
        errors.add(:from_name, "#{from_name} is not a valid city")
      end
    end

  end

  def convert_prority_to_int

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
