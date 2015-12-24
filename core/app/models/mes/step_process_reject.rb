module Mes
  class StepProcessReject < ActiveRecord::Base
    belongs_to :step_code
    belongs_to :product, optional: true
    belongs_to :order_type, optional: true
    has_many :step_process_reject_codes

    def reject_codes
      step_process_reject_codes.map(&:reject_code)
    end

    def reject_codes=(values)
      if new_record?
        (values - reject_codes).each do |to_new|
          step_process_reject_codes.build(reject_code: to_new) unless to_new.blank?
        end
      else
        step_process_reject_codes.where(reject_code: reject_codes - values).each do |to_destroy|
          step_process_reject_codes.destroy(to_destroy)
        end
        (values - reject_codes).each do |to_add|
          step_process_reject_codes.create(reject_code: to_add) unless to_add.blank?
        end
      end
    end
  end
end
