class Mes::BaseController < ApplicationController
end

Mes::BaseController.send(:include, Mes::ViewContext)
