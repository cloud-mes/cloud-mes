module Mes
  class Product < ActiveRecord::Base
    validates :product_code, presence: true, uniqueness: true
  end
end
