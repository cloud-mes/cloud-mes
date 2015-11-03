module Mes
  class Machine < ActiveRecord::Base
    scope :preload_machine_type, -> { includes(:machine_type) }
    belongs_to :machine_type
    validates :machine_code, presence: true, uniqueness: true
    validates :machine_type, presence: true
  end
end
