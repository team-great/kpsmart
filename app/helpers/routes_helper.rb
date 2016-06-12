require 'routing/graph'

module RoutesHelper


  # Get a path between the the starting city and end city
  # Returns:
  #   On successful: a hash which contains distance and routes
  #   On failure: nil
  def get_route(start_city, end_city)
    graph = Graph.new
    City.all.each {|node| graph.push node.id }


    #TODO: change to connect once seeds are corrected
    Route.all.order(from_id: :asc).each do |route|
      graph.connect_mutually route.from_id, route.to_id, route.duration.to_i
    end

    start_point = City.get_id_from_name(start_city).to_i # starting node
    end_point = City.get_id_from_name(end_city).to_i # arrival node

    results = graph.dijkstra(start_point, end_point)

    if results == nil
      return {
        valid: false,
        results: [name: "No route found"],
        distance: 0
      }
    end

    distance = results[:distance] #graph.length_between(start_point, end_point)

    names = []
    results[:path].each do |res|
      name = City.find_by(id: res)
      names.push name
    end

    return {
      valid: true,
      results: names,
      distance: distance
    }

  end
end
