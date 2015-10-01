module Mes
  module Modeler
    class Engine < ::Rails::Engine
      isolate_namespace Mes::Modeler
    end
  end
end
