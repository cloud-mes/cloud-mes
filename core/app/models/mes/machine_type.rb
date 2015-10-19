module Mes
  class MachineType < ActiveRecord::Base
    validates :machine_type, presence: true, uniqueness: true
  end
end
