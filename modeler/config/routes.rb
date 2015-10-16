Mes::Core::Engine.routes.draw do
  namespace :modeler, path: Mes::Modeler.modeler_path do
    resources :factories, :lot_types, :order_types,
              :hold_reasons, :release_reasons,
              :reject_codes, :bin_codes,
              :step_codes,
              except: :show
  end
end
