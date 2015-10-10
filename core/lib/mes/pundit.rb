require 'pundit'
module Pundit
  def pundit_user
    current_mes_user
  end
end
