require 'mes-core'
require 'jquery/rails'
require 'js_cookie_rails'
require 'bootstrap-sass'
require 'mes/modeler/engine'

module Mes::Modeler
  mattr_accessor :modeler_path
  @@modeler_path = '/'
end
