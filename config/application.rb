require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Vendelo
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    #Se configuran los dos idiomas de la aplicacion 
    config.i18n.available_locales = [:en, :es]

    #Lenguaje por defecto
    config.i18n.default_locale = :es

    #Allow multiquery Permitir query async o asincrono
    config.active_record.async_query_executor = :global_thread_pool

    # Background job
    #Sirve para encolar los jobs en una base de datos local para no perderlo si se reinicia el server
    #Para instalar seguir estos pasos y luego copiar en este directorio config.active_job.....
    #brew install redis
    #bundle add sidekiq
    #Ejecutar esto para que se levante sidekiq 
    #bundle exec sidekiq
    config.active_job.queue_adapter = :sidekiq
  end
end
