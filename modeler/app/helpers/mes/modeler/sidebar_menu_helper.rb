module Mes::Modeler::SidebarMenuHelper
  def sub_menu_product_model(text, id:, icon: nil)
    sub_menu_tree text, id, icon: icon do
      sidebar_menu_item(Mes.t(:products), mes.modeler_products_path) if policy(Mes::Product).index?
      sidebar_menu_item(Mes.t(:workflows), mes.modeler_workflows_path) if policy(Mes::Workflow).index?
    end
  end

  def sub_menu_equipment(text, id:, icon: nil)
    sub_menu_tree text, id, icon: icon do
      sidebar_menu_item(Mes.t(:machine_types), mes.modeler_machine_types_path) if policy(Mes::MachineType).index?
    end
  end

  def sub_menu_configuration(text, id:, icon: nil)
    sub_menu_tree text, id, icon: icon do
      concat sidebar_menu_item(Mes.t(:factories), mes.modeler_factories_path) if policy(Mes::Factory).index?
      concat sidebar_menu_item(Mes.t(:lot_types), mes.modeler_lot_types_path) if policy(Mes::LotType).index?
      concat sidebar_menu_item(Mes.t(:order_types), mes.modeler_order_types_path) if policy(Mes::OrderType).index?
      concat sidebar_menu_item(Mes.t(:hold_reasons), mes.modeler_hold_reasons_path) if policy(Mes::HoldReason).index?
      concat sidebar_menu_item(Mes.t(:release_reasons), mes.modeler_release_reasons_path) if policy(Mes::ReleaseReason).index?
      concat sidebar_menu_item(Mes.t(:reject_codes), mes.modeler_reject_codes_path) if policy(Mes::RejectCode).index?
      concat sidebar_menu_item(Mes.t(:bin_codes), mes.modeler_bin_codes_path) if policy(Mes::BinCode).index?
      concat sidebar_menu_item(Mes.t(:step_codes), mes.modeler_step_codes_path) if policy(Mes::StepCode).index?
      concat sidebar_menu_item(Mes.t(:certifications), mes.modeler_certifications_path) if policy(Mes::Certification).index?
    end
  end

  private

  def sub_menu_tree(text, id, icon: nil)
    content_tag :li, class: 'sidebar-menu-item' do
      concat(main_menu_item(text, url: "##{id}", icon: icon))
      concat(content_tag(:ul, 'data-hook' => "modeler_#{id.underscore}", id: id, class: 'collapse nav nav-pills nav-stacked') do
        yield
      end)
    end
  end
end
