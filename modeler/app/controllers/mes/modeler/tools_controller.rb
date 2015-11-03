class Mes::Modeler::ToolsController < Mes::Modeler::ResourceController
  def collection
    super.preload_tool_part
  end
end
