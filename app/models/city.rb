class City < ActiveRecord::Base
  has_many :to, foreign_key: "to_id",  class_name: "Route"
  has_many :from, foreign_key: "from_id", class_name: "Route"

  def routes
    self.to + self.from
  end 
end
