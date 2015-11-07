module Mes
  class MachineCategory < Mes::NamedType
    has_many :machines
  end
end
