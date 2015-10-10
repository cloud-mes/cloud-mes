class Mes::Modeler::BaseController < Mes::BaseController
  helper 'mes/modeler/navigation'
  layout 'mes/layouts/modeler'

  protected

  def action
    params[:action].to_sym
  end
end
