module Mes
  class Step < ActiveRecord::Base
    belongs_to :workflow
    belongs_to :step_code
    delegate :name, :description, to: :step_code

    validates :step_code, presence: true, uniqueness: { scope: [:workflow_id] }
    validates :workflow, presence: true
  end
end
