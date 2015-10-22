module Mes
  class NamedType < ActiveRecord::Base
    self.abstract_class = true
    validates :name, presence: true, uniqueness: true
  end
end
