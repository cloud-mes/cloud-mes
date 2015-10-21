module Mes
  class Factory < ActiveRecord::Base
    validates :factory_code, :factory_name, presence: true, uniqueness: true
  end
end
