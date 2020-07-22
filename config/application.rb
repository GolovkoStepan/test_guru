# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)
Dotenv::Railtie.load

module TestGuru
  class Application < Rails::Application
    config.load_defaults 6.0
    config.time_zone = 'Ekaterinburg'
    config.i18n.available_locales = %i[en ru]
    config.i18n.default_locale = :ru
    config.autoload_paths += %W[#{Rails.root}/app/services]
  end
end
