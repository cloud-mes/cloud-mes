Mes::Core::Engine.routes.draw do
  namespace :modeler, path: Mes::Modeler.modeler_path do
    resources :factories, :lot_types, :order_types, :hold_reasons, except: :show
  end
end
