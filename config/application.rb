require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rails6template
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.encoding = "utf-8"

    config.action_cable.allowed_request_origins = [
      'dev-recipes.thecovrigs.net',
      'recipes.thecovrigs.net',
      'recipes-app.thecovrigs.net',
      # vuejs
      'localhost:8080',
      '192.168.5.10:8080',
      # vuejs
      'localhost:8081',
      '192.168.5.10:8081',
      # app
      nil
    ]
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins(
          'dev-recipes.thecovrigs.net',
          'recipes.thecovrigs.net',
          'recipe-app.thecovrigs.net',
          # vuejs
          /localhost:.*/,
          /192.168.5.10:.*/,
        )
        resource '*', :headers => :any, expose: %w[access-token expiry token-type uid client], :methods => [:get, :post, :options, :delete], credentials: true
      end
    end
  end
end
