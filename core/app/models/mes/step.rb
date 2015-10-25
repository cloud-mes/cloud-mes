module Mes
  class Step < ActiveRecord::Base
    belongs_to :workflow
    belongs_to :step_code

    validates :step_code, :sequence, presence: true, uniqueness: { scope: [:workflow_id] }
    validates :workflow, presence: true
  end
end
