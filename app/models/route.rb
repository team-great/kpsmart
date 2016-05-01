class Route < ActiveRecord::Base
  belongs_to :to, class_name: 'City'
  belongs_to :from, class_name: 'City'
end
