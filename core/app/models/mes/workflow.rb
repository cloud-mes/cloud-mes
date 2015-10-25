module Mes
  class Workflow < Mes::NamedType
    scope :preload_steps, -> { includes(steps: :step_code) }
    has_many :steps, dependent: :destroy
  end
end
