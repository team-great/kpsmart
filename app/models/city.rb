class City < ActiveRecord::Base
  has_many :to, foreign_key: "to_id",  class_name: "Route"
  has_many :from, foreign_key: "from_id", class_name: "Route"

  def routes
    self.to + self.from
  end

  def self.get_id_from_name(name)

    puts "finding #{name}"

    City.find_by(name: name).id rescue -1

  end

end
