module Mes
  class Tool < ActiveRecord::Base
    enum status: %i(idle active pm_need pm_wip calibration_need calibration_wip obsolete)
    scope :preload_tool_part, -> { includes(:tool_part) }
    belongs_to :tool_part
    validates :tool_code, presence: true, uniqueness: true
    validates :tool_part, presence: true
  end
end
