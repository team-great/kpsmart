class City < ActiveRecord::Base
  has_many :to, foreign_key: "to_id",  class_name: "Route"
  has_many :from, foreign_key: "from_id", class_name: "Route"

  validates :name, presence: true, uniqueness: true

  def routes

    self.to + self.from

  end

  def self.get_id_from_name(name)

    City.find_by(name: name).id rescue nil

  end

end
