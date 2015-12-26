module Mes
  class StepCode < ActiveRecord::Base
    has_many :steps
    validates :name, presence: true, uniqueness: true
    validates :step_type, presence: true
    enum step_type: [:inventory, :wip]

    def full_name
      "#{name} - #{description}"
    end
  end
end
