module Auth
  extend ActiveSupport::Concern

  def current_user
    @current_user = []
    @current_user[0] ||= User.where(api_key: api_key).take unless api_key.blank?
    @current_user[1] ||= current_device
    @current_user
  end

  def current_device
    Device.where(api_key: device_api_key).take unless device_api_key.blank?
  end

  private

  def api_key
    request.headers["X-PushBox-Api-Key"]
  end

  def device_api_key
    request.headers["X-PushBox-Device-Api-Key"]
  end
end
