require 'mes-core'
require 'jquery/rails'
require 'jquery-cookie-rails/rails'
require 'bootstrap-sass'
require 'mes/modeler/engine'

module Mes::Modeler
  mattr_accessor :modeler_path
  @@modeler_path = '/'
end
