class Mes::BaseController < ApplicationController
  include Pundit
  helper_method :current_mes_user
  def current_mes_user
    defined? current_user ? current_user : true
  end
end

Mes::BaseController.send(:include, Mes::ViewContext)
