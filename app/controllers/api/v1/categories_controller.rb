class Api::V1::CategoriesController < Api::V1::BaseController
  def index
    category = Category.all
    render_with_options(
      json: category,
      status: :ok,
      each_serializer: CategorySerializer
    )
  end

  def show
    category = Category.find(params.require(:id))
    render_with_options(
      json: category,
      status: :ok,
      each_serializer: CategorySerializer
    )
  end
end
