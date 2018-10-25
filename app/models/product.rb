class Product < ApplicationRecord
  belongs_to :category
  validates_presence_of :price, :name
end
