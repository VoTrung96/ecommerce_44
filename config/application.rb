require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Ecommerce
  class Application < Rails::Application
    config.load_defaults 5.1
    config.assets.paths << Rails.root.join("vendor", "assets")
  end
end
