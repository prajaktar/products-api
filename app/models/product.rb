require 'csv'
class Product < ApplicationRecord
  belongs_to :categories

  def update(product_details)
    update_attributes!(name: product_details[:name], price: product_details[:price], quantity: product_details[:quantity])
  end

  def self.insert(product_details, category)
    category.products.create!(product_details)
  end

  ## Generate a csv report of produucts based on category
  
  def self.report(category)
    result = []
    result = category.products.map do |product| 
      [product.name, product.price, product.quantity, category.category]
    end
    filename = "#{Rails.root}/tmp/#{category.category}_#{Time.zone.now.strftime('%d-%m-%Y')}"
    generate_csv(result, filename)
    filename
  end

  def self.generate_csv(result, filename)
    CSV.open(filename, "wb") do |csv|
      result.each do |value|
        csv << value
      end
    end
  end
end
