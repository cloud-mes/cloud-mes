module Mes
  class HoldReason < ActiveRecord::Base
    validates :hold_reason, presence: true, uniqueness: true
  end
end
