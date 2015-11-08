module Mes
  class ToolCategory < Mes::NamedType
    has_many :tools
  end
end
