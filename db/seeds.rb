# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@routes = []

initial_transport_routes = [
  # Create some transport routes
  # NZ depots - Auckland, Hamilton, Rotorua, Palmerston North, Wellington, Christchurch, Dunedin

  #       0,     1,   2,   3,           4,          5,         6,      7,        8,    9
  # company, start, end, type, weightcost, volumecost, maxWeight, maxVol, duration, freq

  # connecting all nz cities, which counts as free.
  [ "Air New Zealand", "Auckland", "Hamilton", "Air", 0, 0, 1000, 1000, 3, 36],
  [ "Air New Zealand", "Rotorua", "Hamilton", "Air", 0, 0, 1000, 1000, 3, 36],
  [ "Air New Zealand", "Rotorua", "Palmerston North", "Air", 0, 0, 1000, 1000, 3, 36],
  [ "Air New Zealand", "Wellington", "Palmerston North", "Air", 0, 0, 1000, 1000, 3, 36],
  [ "Air New Zealand", "Wellington", "Christchurch", "Air", 0, 0, 1000, 1000, 3, 36],
  [ "Air New Zealand", "Dunedin", "Christchurch", "Air", 0, 0, 1000, 1000, 3, 36],

  # will connect auckland with a handful of int'l cities by air
  [ "Air New Zealand", "Auckland", "Sydney", "Air", 6, 6, 300, 50, 5, 14],
  [ "Air New Zealand", "Auckland", "Singapore", "Air", 9, 8, 300, 50, 6, 14],
  [ "Air New Zealand", "Auckland", "Tokyo", "Air", 9, 8, 300, 50, 13, 14],
  [ "Air New Zealand", "Auckland", "Beijing", "Air", 11, 15, 250, 50, 19, 14],
  [ "Air New Zealand", "Auckland", "Bangkok", "Air", 10, 12, 200, 50, 12, 14],
  [ "Air New Zealand", "Auckland", "New York", "Air", 15, 16, 260, 50, 20, 14],
  [ "Air New Zealand", "Auckland", "Buenos Aires", "Air", 15, 16, 200, 50, 22, 14],
  [ "Air New Zealand", "Auckland", "Suva", "Air", 15, 16, 2000, 50, 4, 14],
  [ "Air New Zealand", "Auckland", "Jakarta", "Air", 15, 16, 2000, 50, 8, 14],
  [ "Air New Zealand", "Auckland", "London", "Air", 15, 16, 2000, 50, 17, 14],
  [ "Air New Zealand", "Auckland", "Berlin", "Air", 15, 16, 2000, 50, 15, 14],
  [ "Air New Zealand", "Auckland", "Istanbul", "Air", 15, 16, 2000, 50, 20, 14],

  # will connect auckland with a handful of int'l cities by sea
  [ "NZ Shipping", "Auckland", "Sydney", "Sea", 6, 6, 300, 50, 25, 14],
  [ "NZ Shipping", "Auckland", "Singapore", "Sea", 9, 8, 300, 50, 26, 14],
  [ "NZ Shipping", "Auckland", "Tokyo", "Sea", 9, 8, 300, 50, 33, 14],
  [ "NZ Shipping", "Auckland", "Beijing", "Sea", 11, 15, 250, 50, 39, 14],
  [ "NZ Shipping", "Auckland", "Bangkok", "Sea", 10, 12, 200, 50, 32, 14],
  [ "NZ Shipping", "Auckland", "New York", "Sea", 15, 16, 260, 50, 30, 14],
  [ "NZ Shipping", "Auckland", "Buenos Aires", "Sea", 15, 16, 200, 50, 42, 14],
  [ "NZ Shipping", "Auckland", "Suva", "Sea", 15, 16, 2000, 50, 24, 14],
  [ "NZ Shipping", "Auckland", "Jakarta", "Sea", 15, 16, 2000, 50, 28, 14],
  [ "NZ Shipping", "Auckland", "London", "Sea", 15, 16, 2000, 50, 37, 14],
  [ "NZ Shipping", "Auckland", "Havana", "Sea", 15, 16, 2000, 50, 37, 14],

  # now connecting some of those cities to some more cities
  [ "Virgin International", "New York", "Mexico City", "Air", 15, 16, 2000, 50, 5, 14],
  [ "Virgin International", "New York", "Toronto", "Air", 15, 16, 2000, 50, 5, 14],
  [ "Virgin International", "New York", "Havana", "Air", 15, 16, 2000, 50, 5, 14],
  [ "Virgin International", "London", "Mexico City", "Air", 15, 16, 2000, 50, 15, 14],
  [ "Virgin International", "London", "Toronto", "Air", 15, 16, 2000, 50, 15, 14],
  [ "Virgin International", "London", "Havana", "Air", 15, 16, 2000, 50, 15, 14],
  [ "Virgin International", "Buenos Aires", "Havana", "Air", 15, 16, 2000, 50, 8, 14],
  [ "Virgin International", "Buenos Aires", "Toronto", "Air", 15, 16, 2000, 50, 12, 14],
  [ "Virgin International", "Buenos Aires", "Mexico City", "Air", 15, 16, 2000, 50, 9, 14],
  [ "Virgin International", "Istanbul", "Prague", "Air", 15, 16, 2000, 50, 5, 14],

  # now connecting some of those cities to some more cities by sea
  [ "Tolstoy Shipping", "New York", "Mexico City", "Sea", 15, 16, 2000, 50, 50, 14],
  [ "Tolstoy Shipping", "New York", "Toronto", "Sea", 15, 16, 2000, 50, 45, 14],
  [ "Tolstoy Shipping", "New York", "Havana", "Sea", 15, 16, 2000, 50, 35, 14],
  [ "Tolstoy Shipping", "London", "Toronto", "Sea", 15, 16, 2000, 50, 35, 14],
  [ "Tolstoy Shipping", "London", "Havana", "Sea", 15, 16, 2000, 50, 55, 14],
  [ "Tolstoy Shipping", "Buenos Aires", "Havana", "Sea", 15, 16, 2000, 65, 58, 14],
  [ "Tolstoy Shipping", "Buenos Aires", "Montevideo", "Sea", 15, 16, 2000, 25, 58, 14],
  [ "Tolstoy Shipping", "Buenos Aires", "Port of Spain", "Sea", 15, 16, 2000, 65, 58, 14]




]


initial_transport_routes.each do |route|
  # can move this out if we bother to set lat & long
  to = City.where(name: route[1]).first_or_create.name
  from = City.where(name: route[2]).first_or_create.name

  r = Route.create(provider: route[0],
               to_name: to,
               from_name: from,
               priority_name: route[3],
               weight_cost: route[4],
               volume_cost: route[5],
               weight_price: route[4],
               volume_price: route[5],
               max_weight: route[6],
               max_volume: route[7],
               duration: route[8],
               frequency: route[9],
               day: 'Monday')

  unless r.save
    puts r.errors.messages
  end
  @routes << r
end



mail_delivery = [
  # day, to, from, weight, volume, priority
  [ "Monday", "Prague", "Wellington", 90, 5, "Air"],
  [ "Tuesday", "Istanbul", "Dunedin", 80, 6, "Air"],
  [ "Wednesday", "London", "Wellington", 90, 7, "Air"],
  [ "Friday", "Buenos Aires", "Hamilton", 70, 8, "Air"],
  [ "Monday", "Berlin", "Dunedin", 50, 9, "Air"],
  [ "Monday", "Bangkok", "Wellington", 130, 10, "Air"],
  [ "Friday", "Beijing", "Hamilton", 102, 11, "Air"],
  [ "Tuesday", "Buenos Aires", "Dunedin", 120, 3, "Air"],
  [ "Monday", "Mexico City", "Wellington", 100, 4, "Air"],
  [ "Wednesday", "Sydney", "Hamilton", 10, 5, "Air"],
  [ "Tuesday", "Singapore", "Dunedin", 50, 6, "Air"],
  [ "Monday", "Havana", "Wellington", 90, 5, "Air"],
  [ "Monday", "Suva", "Wellington", 80, 5, "Air"],
  [ "Tuesday", "Havana", "Hamilton", 70, 5, "Air"],
  [ "Monday", "Havana", "Wellington", 60, 3, "Air"],
  [ "Monday", "Havana", "Auckland", 50, 4, "Air"],
  [ "Tuesday", "Istanbul", "Dunedin", 30, 6, "Air"],
  [ "Wednesday", "London", "Wellington", 90, 7, "Air"],
  [ "Friday", "Suva", "Hamilton", 70, 8, "Air"],
  [ "Friday", "Suva", "Hamilton", 70, 8, "Air"],
  [ "Monday", "Jakarta", "Dunedin", 50, 9, "Air"],
  [ "Monday", "Bangkok", "Wellington", 130, 10, "Air"],
  [ "Friday", "Beijing", "Hamilton", 102, 11, "Air"],
  [ "Tuesday", "Jakarta", "Dunedin", 120, 3, "Air"],
  [ "Monday", "Mexico City", "Wellington", 100, 4, "Air"],
  [ "Wednesday", "Jakarta", "Hamilton", 10, 5, "Air"],
  [ "Monday", "Havana", "Wellington", 60, 3, "Sea"],
  [ "Monday", "Havana", "Auckland", 50, 4, "Sea"],
  [ "Tuesday", "Istanbul", "Dunedin", 30, 6, "Sea"],
  [ "Wednesday", "London", "Wellington", 90, 7, "Sea"],
  [ "Friday", "Suva", "Hamilton", 70, 8, "Sea"],
  [ "Friday", "Suva", "Hamilton", 70, 8, "Sea"],
  [ "Monday", "Jakarta", "Dunedin", 50, 9, "Sea"],
  [ "Monday", "Bangkok", "Wellington", 130, 10, "Sea"],
  [ "Friday", "Beijing", "Hamilton", 102, 11, "Sea"],
  [ "Tuesday", "Jakarta", "Dunedin", 120, 3, "Sea"],
  [ "Monday", "Mexico City", "Wellington", 100, 4, "Sea"],
  [ "Wednesday", "Jakarta", "Hamilton", 10, 5, "Sea"],
  [ "Wednesday", "Montevideo", "Hamilton", 10, 5, "Sea"]
]

mail_delivery.each do |mail|

  to = City.where(name: mail[1]).first_or_create.name
  from = City.where(name: mail[2]).first_or_create.name

	m = MailDelivery.create(day: mail[0],
									 to_name: to,
									 from_name: from,
									 weight: mail[3],
									 volume: mail[4],
									 priority_name: mail[5])

  unless m.save

    puts m.errors.messages

  end

  m.routes << @routes[10]
  m.routes << @routes[11]
  m.routes << @routes[12]

end


User.create!(email: "clerk@kps.com", password: "12345")
User.create!(email: "manager@kps.com", password: "12345")


=begin
transport_cost_update = [
  #same fields as route creation
  # the first three change the weightcost
  [ "Air New Zealand", "Auckland", "Sydney", "Air", 7, 6, 300, 50, 5, 14],
  [ "Air New Zealand", "Auckland", "Singapore", "Air", 10, 8, 300, 50, 6, 14],
  [ "Air New Zealand", "Auckland", "Tokyo", "Air", 8, 8, 300, 50, 13, 14],
  # these  three change the volumecost
  [ "Air New Zealand", "Auckland", "Sydney", "Air", 7, 8, 300, 50, 5, 14],
  [ "Air New Zealand", "Auckland", "Singapore", "Air", 10, 9, 300, 50, 6, 14],
  [ "Air New Zealand", "Auckland", "Tokyo", "Air", 8, 10, 300, 50, 13, 14],
  # these change both
  [ "Air New Zealand", "Auckland", "Sydney", "Air", 8, 9, 300, 50, 5, 14],
  [ "Air New Zealand", "Auckland", "Singapore", "Air", 11, 10, 300, 50, 6, 14],
  [ "Air New Zealand", "Auckland", "Tokyo", "Air", 9, 11, 300, 50, 13, 14]
]
customer_price_update [
  # company, to ,from, type
  [ "Rome", "New Zealand", "International Air", 6, 8 ]
]
discontinue [
  [ "Air New Zealand", "Sydney", "Wellington", "Air" ]
]
=end
