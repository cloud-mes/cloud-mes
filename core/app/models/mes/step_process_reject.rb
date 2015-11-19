module Mes
  class StepProcessReject < ActiveRecord::Base
    belongs_to :step_code
    belongs_to :product, optional: true
    belongs_to :order_type, optional: true
    has_many :step_process_reject_codes
  end
end
