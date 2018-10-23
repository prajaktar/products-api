class Api::V1::ProductsController < Api::V1::BaseController
  before_action :intialize_category

  def index
    products = @category.products.all
    render_with_options(
      json: products,
      status: :ok,
      each_serializer: ProductSerializer
    )
  end

  def show
    products = @category.products.find(params.require(:id))
    render_with_options(
      json: products,
      status: :ok,
      each_serializer: ProductSerializer
    )
  end

  def update
    product = @category.products.find(params.require(:id))
    response = product.update(product_params)
    render_with_options(
      json: response,
      status: :ok,
      each_serializer: ProductSerializer
    )
  end

  def create
    response = Product.insert(product_params, @category)
    render_with_options(
      json: response,
      status: :ok,
      each_serializer: ProductSerializer
    )
  end

  def download
    filename = Product.report(@category)
    if File.exist?(filename)
      send_file("#{filename}", filename: "#{filename}", type: CSV_CONTENT_TYPE, stream: false)
    else
      render_with_options(
        json: {error: "Error generating report."},
        status: :not_found,
      )
    end  
  end

  private

  def product_params
    params.permit([:name, :price, :quantity])
  end

  def intialize_category
    @category = Category.find(params.require(:category_id))
  end

end
