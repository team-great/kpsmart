class RoutesController < ApplicationController
  include RoutesHelper
  before_action :set_route, only: [:show, :edit, :update, :destroy]
  # GET /routes
  # GET /routes.json
  def index

    @routes = Route.all

  end

  #GET /routes/new_from_xml
  def new_from_xml
  end

  #POST /routes/new_from_xml/submit
  def new_from_xml_results

    doc = Nokogiri::XML(params[:xml_data])

    doc.root.xpath('//cost').each do |cost|
      compay = cost.xpath('company').text
      to = cost.xpath('to').text
      from = cost.xpath('from').text
      type = cost.xpath('type').text
      weightcost = cost.xpath('weightcost').text
      volumecost = cost.xpath('volumecost').text
      maxWeight = cost.xpath('maxWeight').text
      maxVolume = cost.xpath('maxVolume').text
      duration = cost.xpath('duration').text
      frequency = cost.xpath('frequency').text
      day = cost.xpath('day').text
      route_params = {provider: compay,
                      to_name: to,
                      from_name: from,
                      priority_name: type,
                      weight_cost: weightcost,
                      volume_price: volumecost,
                      max_weight: maxWeight,
                      max_volume: maxVolume,
                      duration: duration,
                      frequency: frequency,
                      day: day}
      to_id = City.get_id_from_name(to)
      from_id = City.get_id_from_name(from)
      if !to_id || !from_id
        puts 'error one of these cities cant be found: '+ to.to_s + ' id:'+ to_id.to_s + "  " + from.to_s + " id: " + from_id.to_s
        break
      end
      route = Route.find_or_initialize_by({to_id: to_id, from_id: from_id, provider: compay})
      route.priority_name = type
      route.weight_cost = weightcost
      route.volume_price = volumecost
      route.max_weight = maxWeight
      route.max_volume = maxVolume
      route.duration = duration
      route.frequency = frequency
      route.day = day
      route.save
    end


    #@results = doc.root
  end

  def find
  end

  def find2

    result = get_route params[:city_from], params[:city_to]
    @results = result[:results]
    @distance = result[:distance]

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
    @route = Route.find_by(id: params[:id])
  end

  # Whitelist parameters
  def route_params
    params.require(:route).permit(:to_name, :from_name, :priority, :priority_name, :provider, :weight_cost, :volume_cost, :weight_price, :volume_price, :max_weight, :max_volume, :duration, :frequency, :day)
  end
end
