class Api::V1::ProductsController < Api::V1::BaseController
  before_action :set_category
  before_action :set_product, except: [:download, :index, :create]

  def index
    render json: @category.products
  end

  def show
    render json: @product
  end

  def update
    @product.update(product_params)
    render json: @product
  end

  def create
    render json: @category.products.create!(product_params)
  end

  def download
    filename = @category.report
    if File.exist?(filename)
      send_file("#{filename}", filename: "#{filename}", type: CSV_CONTENT_TYPE, stream: false)
    else
      render json: {error: "Error generating report."}
    end  
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :quantity)
  end

  def set_category
    @category = Category.find(params.require(:category_id))
  end

  def set_product
    @product = @category.products.find(params.require(:id))
  end
end
