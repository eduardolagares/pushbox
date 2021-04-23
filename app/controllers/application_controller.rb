class ApplicationController < ActionController::API
    include Pundit
    include Auth
end
