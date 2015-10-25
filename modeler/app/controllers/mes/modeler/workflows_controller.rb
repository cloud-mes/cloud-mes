class Mes::Modeler::WorkflowsController < Mes::Modeler::ResourceController
  def collection
    super.preload_steps
  end
end
