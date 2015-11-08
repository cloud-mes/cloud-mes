module Mes
  class Component < ActiveRecord::Base
    scope :preload_component_types, -> { includes(:component_type) }
    belongs_to :component_category, optional: true
    belongs_to :component_type
    validates :component_code, presence: true, uniqueness: true
    validates :component_type, presence: true
  end
end
