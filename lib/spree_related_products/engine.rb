module SpreeRelatedProducts
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_related_products'

    config.autoload_paths += %W(#{config.root}/lib #{config.root}/app/models/spree/calculator)

    initializer 'spree_related_products.add_menu_item' do |app|
      Spree::Backend::Config.configure do |config|
        config.menu_items << config.class::MenuItem.new(
          [:related_products],
          'project-diagram',
          url: :related_admin_products_path,
          condition: -> { can?(:manage, Spree::Product) }
        )
      end if defined?(Spree::Backend::Config)
    end
    class << self
      def activate
        cache_klasses = %W(#{config.root}/app/**/*_decorator*.rb)
        Dir.glob(cache_klasses) do |klass|
          Rails.configuration.cache_classes ? require(klass) : load(klass)
        end
      end
    end

    config.to_prepare(&method(:activate).to_proc)
  end
end
