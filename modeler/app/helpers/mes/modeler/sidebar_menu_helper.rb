module Mes::Modeler::SidebarMenuHelper
  def sub_menu_product_model(text, id:, icon: nil)
    sub_menu_tree text, id, icon: icon do
      sidebar_menu_item(Mes.t(:workflows), mes.modeler_workflows_path) if policy(Mes::Workflow).index?
    end
  end

  def sub_menu_equipment(text, id:, icon: nil)
    sub_menu_tree text, id, icon: icon do
      sidebar_menu_item(Mes.t(:machine_types), mes.modeler_machine_types_path) if policy(Mes::MachineType).index?
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
