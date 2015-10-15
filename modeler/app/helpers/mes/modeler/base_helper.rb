module Mes::Modeler::BaseHelper
  def flash_alert(flash)
    return unless flash.present?
    message = flash[:error] || flash[:notice] || flash[:success]
    flash_class = 'danger' if flash[:error]
    flash_class = 'info' if flash[:notice]
    flash_class = 'success' if flash[:success]
    flash_div = content_tag(:div, message, class: "alert alert-#{flash_class} alert-auto-disappear")
    content_tag(:div, flash_div, class: 'col-md-12')
  end

  def field_container(model, method, options = {}, &block)
    css_classes = options[:class].to_a
    css_classes << 'field'
    css_classes << 'withError' if error_message_on(model, method).present?
    content_tag(:div, capture(&block), class: css_classes.join(' '), id: "#{model}_#{method}_field")
  end

  def error_message_on(object, method)
    object = convert_to_model(object)
    obj = object.respond_to?(:errors) ? object : instance_variable_get("@#{object}")

    if obj && obj.errors[method].present?
      errors = obj.errors[method].map { |err| h(err) }.join('<br />').html_safe
      content_tag(:span, errors, class: 'formError')
    else
      ''
    end
  end

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
