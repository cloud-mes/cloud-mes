module Mes
  class MachineType < Mes::NamedType
    has_many :machines
  end
end
