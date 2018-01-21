class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound , with: :record_not_found
  rescue_from NameError, with: :error_occurred
  rescue_from ActionController::RoutingError, with: :error_occurred
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  protected
    def error_occurred(exception)
      render json: { error: exception.message }.to_json, status: 500
    end

    def record_invalid(exception)
      render json: { error: exception.message }, status: :unprocessable_entity
    end

    def record_not_found(exception)
      render json: { error: "Location not fount" }, status: 404
    end
end
