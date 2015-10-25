class Mes::Modeler::BaseController < Mes::BaseController
  helper 'mes/modeler/navigation'
  helper 'mes/modeler/sidebar_menu'
  layout 'mes/layouts/modeler'

  protected

  def action
    params[:action].to_sym
  end

  def flash_message_for(object, event_sym)
    resource_desc  = object.class.model_name.human
    resource_desc += " \"#{object.name}\"" if object.respond_to?(:name) && object.name.present?
    Mes.t(event_sym, resource: resource_desc)
  end
end
