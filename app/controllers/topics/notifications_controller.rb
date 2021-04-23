module Topics
  class NotificationsController < ApplicationController
    before_action :set_topic

    # POST /topics/1/notifications
    def create
      authorize :notification, :create?

      @notification = Notification.new(notification_params)

      provider = Provider.by_label(params[:provider_label]).take

      raise "Provider #{params[:provider_label]} undefined or not found" and return unless provider

      @notification.destiny = @topic
      @notification.provider = provider

      if @notification.save
        render json: @notification, status: :created
      else
        render json: @notification.errors, status: :unprocessable_entity
      end
    end

    private

    def set_topic
      @topic = Topic.find(params[:topic_id])
    end

    def notification_params
      params.permit(:title, :subtitle, :body, :body_type, :data, :tag)
    end
  end
end
