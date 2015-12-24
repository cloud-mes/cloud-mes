require 'jquery/rails'
require 'jquery-ui-rails'
require 'js_cookie_rails'
require 'jquery-hoverIntent-rails'
require 'select2-rails'
require 'sprockets/rails'
require 'bootstrap-sass'
require 'mes-core'
require 'mes/modeler/engine'

module Mes::Modeler
  mattr_accessor :modeler_path
  @@modeler_path = '/'
end
