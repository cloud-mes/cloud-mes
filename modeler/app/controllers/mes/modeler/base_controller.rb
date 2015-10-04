class Mes::Modeler::BaseController < ActionController::Base
  layout '/mes/layouts/modeler'

  protected

  def action
    params[:action].to_sym
  end
end
