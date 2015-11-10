module Mes
  class LowYieldSetting < ActiveRecord::Base
    belongs_to :step_code
    belongs_to :product, optional: true
    belongs_to :order_type, optional: true
  end
end
