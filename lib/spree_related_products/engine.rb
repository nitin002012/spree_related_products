module SpreeRelatedProducts
  class Engine < Rails::Engine
    initializer "spree_related_products.configure_rails_initialization" do
      config.autoload_paths ||= []
      config.autoload_paths << "#{root}/lib"
    end
  end
end
