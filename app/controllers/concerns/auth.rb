module Auth

    extend ActiveSupport::Concern

  included do
    before_action :authorize_user
  end

  def current_user
    @current_user ||= User.where(api_key: api_key).take
  end

  private

  def api_key
    request.headers["PushBox-Api-Key"]
  end

  def authorize_user
    head(:unauthorized) and raise "Api Key invalid." unless current_user
  end

end
