module Mes::Modeler::BaseHelper
  def modeler_dom_id(record)
    dom_id(record, 'modeler')
  end

  def modeler_title
    if content_for? :title
      yield :title
    else
      "Cloud MES #{Mes.t('modeler')}: #{Mes.t(controller.controller_name, default: controller.controller_name.titleize)}"
    end
  end
end
