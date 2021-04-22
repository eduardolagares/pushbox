class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :update, :destroy]

  # GET /devices
  def index
    @devices = Device.all

    render json: @devices
  end

  # GET /devices/1
  def show
    render json: @device
  end

  # POST /devices
  def create
    @device = find_or_new

    status = @device.id.nil? ? :created : 200
    if @device.save
      render json: @device, status: status, location: @device
    else
      render json: @device.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /devices/1
  def update
    if @device.update(update_device_params)
      render json: @device
    else
      render json: @device.errors, status: :unprocessable_entity
    end
  end

  # DELETE /devices/1
  def destroy
    @device.destroy
  end

  private
    #Find the device before create
    def find_or_new
      device = Device.where({
        provider_identifier: create_device_params[:provider_identifier], 
        provider_id: create_device_params[:provider_id], 
        system_id: create_device_params[:system_id]
      }).take

      device&.update(update_device_params)
      
      device ||= Device.new(create_device_params)
      device
    end

    # Convert param provider_alias in a provider_id
    def fix_provider_alias_params
      if !params[:provider_alias].blank?
        params[:provider_id] = Provider.by_alias(params[:provider_alias]).take&.id
      end
    end

    # Convert param system_alias in a system_id
    def fix_system_alias_params
      if !params[:system_alias].blank?
        params[:system_id] = System.by_alias(params[:system_alias]).take&.id
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def create_device_params
      fix_provider_alias_params
      fix_system_alias_params
      params.permit(:provider_id, :system_id, :provider_identifier, :external_identifier, extra_data: {}, tags: [])
    end

    def update_device_params
      params.permit(:external_identifier, extra_data: {}, tags: [])
    end
end
