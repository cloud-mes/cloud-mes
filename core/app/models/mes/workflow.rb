module Mes
  class Workflow < Mes::NamedType
    scope :preload_steps, -> { includes(steps: :step_code) }
    has_many :steps, -> { order :sequence }, dependent: :destroy
    accepts_nested_attributes_for :steps, allow_destroy: true, reject_if: :all_blank
  end
end
