module Mes
  class Workflow < Mes::NamedType
    has_many :steps, dependent: :destroy
  end
end
