module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end
  end

  def not_found
    msg = I18n.t 'controllers.report.query.record_not_found'
    render_with_options(
      json: { error: msg },
      status: :not_found
    )
  end

  private

  def json_response(object, status = :ok)
    render json: object, status: status
  end

end
