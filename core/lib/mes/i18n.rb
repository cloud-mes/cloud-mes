require 'mes/i18n/base'

module Mes
  extend ActionView::Helpers::TranslationHelper

  class << self
    # Add mes namespace and delegate to Rails TranslationHelper for some nice
    # extra functionality. e.g return reasonable strings for missing translations
    def translate(*args)
      @virtual_path = virtual_path

      options = args.extract_options!
      options[:scope] = [*options[:scope]].unshift(:mes)
      args << options
      super(*args)
    end

    alias_method :t, :translate

    def virtual_path
      context = Mes::ViewContext.context
      path = context.instance_variable_get('@virtual_path') if context
      path.gsub(/mes/, '') if path
    end
  end
end
