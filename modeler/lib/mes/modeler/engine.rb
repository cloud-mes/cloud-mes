module Mes
  module Modeler
    class Engine < ::Rails::Engine
      isolate_namespace Mes
      engine_name 'modeler'

      # sets the manifests / assets to be precompiled, even when initialize_on_precompile is false
      initializer 'modeler.assets.precompile', group:  :all do |app|
        app.config.assets.precompile += %w(
          mes/modeler.js
          mes/modeler.css
        )
      end
    end
  end
end
