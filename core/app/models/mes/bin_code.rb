module Mes
  class BinCode < ActiveRecord::Base
    self.primary_key = 'bin_code'
    validates :bin_code, presence: true, uniqueness: true
    enum bin_type: [:accept, :reject, :rework]
  end
end
