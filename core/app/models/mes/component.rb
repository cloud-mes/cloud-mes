module Mes
  class Component < ActiveRecord::Base
    validates :component_code, presence: true, uniqueness: true
    validates :component_type, presence: true
  end
end
