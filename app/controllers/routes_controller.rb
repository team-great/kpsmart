class RoutesController < ApplicationController
  include RoutesHelper
  before_action :set_route, only: [:show, :edit, :update, :destroy]
  # GET /routes
  # GET /routes.json
  def index

    @routes = Route.all

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
