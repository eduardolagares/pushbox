class DevicesController < ApplicationController
  before_action :set_device, only: %i[show update destroy]

  # GET /devices
  def index
    @devices = Device.by_system_label(params[:system_label]).by_provider_label(params[:provider_label])
                     .by_external_identifier(params[:external_identifier])
                     .by_tag(params[:tag])
                     .page(params[:page] || 1)
                     .per(params[:per_page] || Kaminari.config.default_per_page)

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

  # Find the device before create
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

  # Convert param provider_label in a provider_id
  def fetch_provider_by_label
    params[:provider_id] = Provider.by_label(params[:provider_label]).take&.id unless params[:provider_label].blank?
  end

  # Convert param system_label in a system_id
  def fetch_system_by_label
    params[:system_id] = System.by_label(params[:system_label]).take&.id unless params[:system_label].blank?
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_device
    @device = Device.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def create_device_params
    fetch_provider_by_label
    fetch_system_by_label
    params.permit(:provider_id, :system_id, :provider_identifier, :external_identifier, extra_data: {}, tags: [])
  end

  def update_device_params
    params.permit(:external_identifier, extra_data: {}, tags: [])
  end
end
