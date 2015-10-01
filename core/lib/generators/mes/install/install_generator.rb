module Mes
  class InstallGenerator < Rails::Generators::Base
    desc 'Install Cloud-MES files'
    source_root File.expand_path('../templates', __FILE__)

    def create_overrides_directory
      empty_directory 'app/overrides'
    end

    def configure_application
      application <<-APP

    config.to_prepare do
      # Load application's view overrides
      Dir.glob(File.join(File.dirname(__FILE__), "../app/overrides/*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end
      APP
    end

    def install_migrations
      say_status :copying, 'migrations'
      rake 'railties:install:migrations'
    end
  end
end
