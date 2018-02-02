ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Dummy
  class Application < Rails::Application
    # config.root = Pathname.new(File.expand_path('../..', __FILE__))

    config.paths['db/migrate'] << '../db/migrate/'

    # configs from development
    config.cache_classes = false
    config.eager_load = false
    config.consider_all_requests_local = true
    config.action_controller.perform_caching = false
    config.action_mailer.raise_delivery_errors = false
    config.active_support.deprecation = :stderr
    config.active_record.migration_error = :page_load
    config.assets.debug = true
    config.assets.digest = true
    config.assets.raise_runtime_errors = true

    # from original dummy app
    config.active_record.raise_in_transactional_callbacks = true
    config.secret_key_base = Rails.application.secrets.secret_key_base
    config.serve_static_files = true
    config.static_cache_control = 'public, max-age=3600'
    config.action_dispatch.show_exceptions = false
    config.action_controller.allow_forgery_protection = false
    config.action_mailer.delivery_method = :test
  end
end

# Initialize the Rails application.
Rails.application.initialize!