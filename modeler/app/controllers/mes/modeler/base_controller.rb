class Mes::Modeler::BaseController < Mes::BaseController
  layout '/mes/layouts/modeler'

  protected

  def action
    params[:action].to_sym
  end
end
