class Api::V1::ProductsController < Api::V1::BaseController
  before_action :intialize_product, except: :download

  def index
    render json: @product
  end

  def show
    render json: @product.find(params.require(:id))
  end

  def update
    product = @product.find(params.require(:id))
    render json: product.update(product_params)
  end

  def create
    render json: @product.create!(product_params)
  end

  def download
    filename = Category.find(params.require(:category_id)).report
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

  def intialize_product
    @product = Category.find(params.require(:category_id)).products
  end
end
