class Route < ActiveRecord::Base
  belongs_to :to, class_name: 'City'
  belongs_to :from, class_name: 'City'

  before_validation(on: [:create, :update]) do

    convert_node_names_to_ids

  end

  attr_accessor :to_name, :from_name
  has_paper_trail


  validates :to_id, :numericality => {allow_blank: false,
                                      greater_than_or_equal_to: 0,
                                      message: 'Unable to find starting city node for given city name.'
  }, on: :create

  validates :from_id, :numericality => {allow_blank: false,
                                        greater_than_or_equal_to: 0,
                                        message: 'Unable to find destination city node for given city name.'
  }, on: :create

  validates :priority,
            :weight_cost,
            :volume_cost,
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

    puts self.inspect

    self.to_id = City.get_id_from_name(to_name)
    self.from_id = City.get_id_from_name(from_name)

  end


end
