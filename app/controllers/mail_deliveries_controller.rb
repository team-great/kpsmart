class MailDeliveriesController < ApplicationController
  before_action :set_mail_delivery, only: [:show, :edit, :update, :destroy]

  attr_accessor :to_name, :from_name

  # GET /mail_deliveries
  # GET /mail_deliveries.json
  def index
    @mail_deliveries = MailDelivery.all
  end

  # GET /mail_deliveries/1
  # GET /mail_deliveries/1.json
  def show
  end

  # GET /mail_deliveries/new
  def new
    @mail_delivery = MailDelivery.new
  end

  # GET /mail_deliveries/1/edit
  def edit
  end

  # POST /mail_deliveries
  # POST /mail_deliveries.json
  def create

    @mail_delivery = MailDelivery.new(mail_delivery_params)

    respond_to do |format|
      if @mail_delivery.save
        format.html { redirect_to @mail_delivery, notice: 'Mail delivery was successfully created.' }
        format.json { render :show, status: :created, location: @mail_delivery }
      else
        format.html { render :new }
        format.json { render json: @mail_delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mail_deliveries/1
  # PATCH/PUT /mail_deliveries/1.json
  def update
    respond_to do |format|
      if @mail_delivery.update(mail_delivery_params)
        format.html { redirect_to @mail_delivery, notice: 'Mail delivery was successfully updated.' }
        format.json { render :show, status: :ok, location: @mail_delivery }
      else
        format.html { render :edit }
        format.json { render json: @mail_delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mail_deliveries/1
  # DELETE /mail_deliveries/1.json
  def destroy
    @mail_delivery.destroy
    respond_to do |format|
      format.html { redirect_to mail_deliveries_url, notice: 'Mail delivery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mail_delivery
      @mail_delivery = MailDelivery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mail_delivery_params
      params.require(:mail_delivery).permit(:day, :to_name, :from_name, :weight, :size, :priority_name)
    end
end
