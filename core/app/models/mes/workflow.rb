module Mes
  class Workflow < ActiveRecord::Base
    validates :workflow_name, presence: true, uniqueness: true
  end
end
