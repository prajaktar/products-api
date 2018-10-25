require 'csv'

class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  ## Generate a csv report of produucts based on category

  def report
    result = products.map do |product|
      [product.name, product.price, product.quantity, category]
    end
    filename = "#{Rails.root}/tmp/#{category}_#{Time.zone.now.strftime('%d-%m-%Y')}"
    generate_csv(result, filename)
    filename
  end

  private

  def generate_csv(result, filename)
    CSV.open(filename, "wb") do |csv|
      result.each do |value|
        csv << value
      end
    end
  end
end
