module Mes
  class Component < ActiveRecord::Base
    belongs_to :component_type
    validates :component_code, presence: true, uniqueness: true
    validates :component_type, presence: true
  end
end
