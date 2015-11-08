module Mes
  class ComponentCategory < Mes::NamedType
    has_many :components
  end
end
