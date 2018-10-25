module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_resource

  def resource_not_found
      render json: { message: e.message }, status: :not_found
    end

    def invalid_resource
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end
end
