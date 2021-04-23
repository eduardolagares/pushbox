class Devices::SubscriptionsController < ApplicationController
  before_action :set_subscription, only: %i[show update destroy]
  before_action :set_device

  # GET /device/:device_id/subscriptions
  def index
    @subscriptions = Subscription.not_canceled.where(device_id: @device.id)

    render json: @subscriptions
  end

  # GET /device/1/subscriptions/1
  def show
    render json: @subscription
  end

  # POST /device/1/subscriptions
  def create
    @subscription = Subscription.new(subscription_params)
    @subscription.canceled = false
    @subscription.status = :synced

    if @subscription.save
      render json: @subscription, status: :created, location: device_subscription_url(@device, @subscription)
    else
      render json: @subscription.errors, status: :unprocessable_entity
    end
  end

  # DELETE /device/1/subscriptions/1
  def destroy
    @subscription.canceled = true
    @subscription.save!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_subscription
    @subscription = Subscription.find(params[:id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_device
    @device = Device.find(params[:device_id])
  end

  # Only allow a list of trusted parameters through.
  def subscription_params
    params.permit(%i[topic_id device_id])
  end
end
