module Mes::Modeler::BaseHelper
  def modeler_dom_id(record)
    dom_id(record, 'modeler')
  end

  I18N_PLURAL_MANY_COUNT = 2.1
  def plural_resource_name(resource_class)
    resource_class.model_name.human(count: I18N_PLURAL_MANY_COUNT)
  end

  def modeler_title
    if content_for? :title
      yield :title
    else
      "Cloud MES #{Mes.t('modeler')}: #{Mes.t(controller.controller_name, default: controller.controller_name.titleize)}"
    end
  end
end
