class RoutesController < ApplicationController
  before_action :set_route, only: [:show, :edit, :update, :destroy]
  # GET /routes
  # GET /routes.json
  def index

    @routes = Route.all

  end

  def find
  end

  def find2

    graph = Graph.new
    (1..City.all.length).each {|node| graph.push node }

    Route.all.order(from_id: :asc).each do |route|
      graph.connect_mutually route.from_id, route.to_id, route.duration.to_i
    end

    start_point = City.get_id_from_name(params[:city_from]).to_i # starting node
    end_point = City.get_id_from_name(params[:city_to]).to_i # arrival node

    results = graph.dijkstra(start_point, end_point)

    if results == nil
      @results = [name: 'no route found']
      @distance = 0
      return
    end

    distance = results[:distance] #graph.length_between(start_point, end_point)

    names = []
    results[:path].each do |res|
      name = City.find_by(id: res)
      names.push name
    end

    #puts 'names: '+names.to_s
    #puts 'cost: '+distance.to_s

    #p graph
    #p graph.dijkstra(start_point, end_point)
    #p graph.length_between(2, 1)
    #p graph.neighbors(1)
    #p graph.dijkstra(1) # => { paths: { node1: [src, node2, dest] }, distances: { node1: 2 } }
    #p graph.dijkstra(2, 1) # => { path: [src, node2, dest], distance: 2 }

    @results = names
    @distance = distance

  end
  # GET /routes/1
  # GET /routes/1.json
  def show
  end

  # GET /routes/new
  def new
    @route = Route.new
  end

  # GET /routes/1/edit
  def edit
  end

  # POST /routes
  # POST /routes.json
  def create

    to_name = params[:to_name]
    from_name = params[:from_name]

    @route = Route.new(route_params)

    @route.to_name = to_name
    @route.from_name = from_name

    respond_to do |format|
      if @route.save
        format.html { redirect_to @route, notice: 'Route was successfully created.' }
        format.json { render :show, status: :created, location: @route }
      else
        format.html { render :new }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /routes/1
  # PATCH/PUT /routes/1.json
  def update
    respond_to do |format|
      if @route.update(route_params)
        format.html { redirect_to @route, notice: 'Route was successfully updated.' }
        format.json { render :show, status: :ok, location: @route }
      else
        format.html { render :edit }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /routes/1
  # DELETE /routes/1.json
  def destroy
    @route.destroy
    respond_to do |format|
      format.html { redirect_to routes_url, notice: 'Route was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_route
    @route = Route.find(params[:id])
  end

  # Whitelist parameters
  def route_params
    params.fetch(:route, {}).permit(:to_name, :from_name, :priority, :provider, :weight_cost, :volume_cost, :max_weight, :max_volume, :duration, :frequency, :day)
  end
end
