module Mes
  module ViewContext
    def self.context=(context)
      @context = context
    end

    def self.context
      @context
    end

    def view_context
      super.tap do |context|
        Mes::ViewContext.context = context
      end
    end
  end
end
