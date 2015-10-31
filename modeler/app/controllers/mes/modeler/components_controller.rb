class Mes::Modeler::ComponentsController < Mes::Modeler::ResourceController
  def collection
    super.preload_component_types
  end
end
