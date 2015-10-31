class Mes::Modeler::MachinesController < Mes::Modeler::ResourceController
  def collection
    super.preload_machine_types
  end
end
