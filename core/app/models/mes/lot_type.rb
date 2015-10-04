module Mes
  class LotType < ActiveRecord::Base
    validates :lot_type, presence: true, uniqueness: true
  end
end
