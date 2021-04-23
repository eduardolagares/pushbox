module Devices
  class NotificationsController < ApplicationController
    before_action :set_device

    # POST /device/1/notifications
    def create
      authorize :notification, :create?

      @notification = Notification.new(notification_params)
      @notification.destiny = @device
      @notification.provider = @device.provider

      if @notification.save
        render json: @notification, status: :created
      else
        render json: @notification.errors, status: :unprocessable_entity
      end
    end

    private

    def set_device
      @device = Device.find(params[:device_id])
    end

    def notification_params
      params.permit(:title, :subtitle, :body, :body_type, :data, :tag)
    end
  end
end
