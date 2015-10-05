module Mes
  module Core
    class Engine < ::Rails::Engine
      isolate_namespace Mes
      engine_name 'mes'
    end
  end
end
