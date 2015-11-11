module Mes
  class StepProcessSetting < ActiveRecord::Base
    belongs_to :step_code
    belongs_to :product, optional: true
    belongs_to :order_type, optional: true
    belongs_to :future_rework_step_code, optional: true, class_name: 'StepCode'

    validates :unit_sample_percent, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 100, allow_nil: true }
  end
end
