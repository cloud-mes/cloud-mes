module CloudMes
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

    def add_routes
      insert_into_file File.join('config', 'routes.rb'), :after => "Rails.application.routes.draw do\n" do
        %Q(  # This line mounts Cloud-MES's routes at the root of your application.
  # This means, any requests to URLs such as /modeler/factories, will go to Mes::Modeler::FactoriesController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  mount Mes::Modeler::Engine, :at => '/modeler'
)
      end

      unless options[:quiet]
        puts "*" * 65
        puts "Following line added to your application's config/routes.rb file:"
        puts " "
        puts "    mount Mes::Modeler::Engine, :at => '/modeler'"
      end
    end
  end
end
