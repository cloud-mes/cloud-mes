module Mes
  class ReleaseReason < ActiveRecord::Base
    validates :release_reason, presence: true, uniqueness: true
  end
end
