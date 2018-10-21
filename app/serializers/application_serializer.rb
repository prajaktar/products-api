class ApplicationSerializer < ActiveModel::Serializer
  include ApplicationHelper
  include ActionView::Helpers::NumberHelper
  include Rails.application.routes.url_helpers
end
