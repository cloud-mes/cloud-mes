module Mes
  class RejectCode < ActiveRecord::Base
    self.primary_key = 'reject_code'
    validates :reject_code, presence: true, uniqueness: true
  end
end
