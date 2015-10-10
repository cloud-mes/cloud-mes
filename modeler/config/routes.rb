Mes::Modeler::Engine.routes.draw do
  namespace :modeler, path: Mes::Modeler.modeler_path do
    resources :factories, :lot_types
  end
end
