class Mes::BaseController < ApplicationController
  include Pundit
  def current_mes_user
    defined? current_user ? current_user : true
  end
end

Mes::BaseController.send(:include, Mes::ViewContext)
