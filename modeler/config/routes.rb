Mes::Modeler::Engine.routes.draw do
  namespace :modeler, path: '/' do
    resources :factories, :lot_types
  end
end
