module Mes
  class OrderTypeSetting < ActiveRecord::Base
    belongs_to :product, optional: true
    belongs_to :order_type, optional: true
  end
end
