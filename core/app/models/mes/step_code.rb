module Mes
  class StepCode < ActiveRecord::Base
    validates :name, presence: true, uniqueness: true
    validates :step_type, presence: true
    enum step_type: [:inventory, :wip]
  end
end
