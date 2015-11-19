Mes::Core::Engine.routes.draw do
  namespace :modeler, path: Mes::Modeler.modeler_path do
    resources :factories, :lot_types, :order_types,
              :hold_reasons, :release_reasons,
              :reject_codes, :bin_codes,
              :step_codes, :workflows,
              :machine_types, :machine_categories, :machines,
              :products, :certifications,
              :component_types, :component_categories, :components,
              :tool_parts, :tool_categories, :tools,
              except: :show

    resources :order_type_settings, :low_yield_settings,
              :step_process_settings, :step_process_rejects,
              except: :show
  end
end
