class Mes::Modeler::WorkflowsController < Mes::Modeler::ResourceController
  def collection
    super.preload_steps
  end

  def find_resource
    Mes::Workflow.preload_steps.find(params[:id])
  end
end
