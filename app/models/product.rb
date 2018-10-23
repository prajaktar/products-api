class Product < ApplicationRecord
  belongs_to :categories
  validates_presence_of :price, :name

  def update(product_details)
    update_attributes!(name: product_details[:name], price: product_details[:price], quantity: product_details[:quantity])
  end
end
