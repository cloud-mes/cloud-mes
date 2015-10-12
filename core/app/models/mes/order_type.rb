module Mes
  class OrderType < ActiveRecord::Base
    validates :order_type, presence: true
  end
end
