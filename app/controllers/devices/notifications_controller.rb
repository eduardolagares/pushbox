module Devices
  class NotificationsController < ApplicationController
    before_action :set_device
    before_action :set_notification, only: [:read]

    # GET /devices/1/notifications
    def index
      authorize :notification, :list?

      unread_count = @device.notifications.not_canceled.where(read: false).count

      @notifications = @device.notifications.not_canceled.order('created_at DESC')
                              .page(params[:page] || 1)
                              .per(params[:per_page] || Kaminari.config.default_per_page)

      render json: { data: @notifications, paging: meta_data(@notifications), meta: { badge_number: unread_count } }
    end

    # POST /devices/1/notifications
    def create
      authorize :notification, :create?

      @notification = Notification.new(notification_params)
      @notification.destiny = @device
      @notification.provider = @device.provider
      @notification.set_to_run_now

      if @notification.save
        render json: @notification, status: :created
      else
        render json: @notification.errors, status: :unprocessable_entity
      end
    end

    def read
      authorize @notification, :read?

      @notification.read = true

      if @notification.save
        render json: @notification
      else
        render json: @notification.errors, status: :unprocessable_entity
      end
    end

    private

    def set_device
      @device = Device.find(params[:device_id])
    end

    def set_notification
      @notification = Notification.find(params[:id])
    end

    def notification_params
      params.permit(:title, :subtitle, :body, :body_type, :tag, data: {})
    end
  end
end
