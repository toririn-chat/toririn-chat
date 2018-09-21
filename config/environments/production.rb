Rails.application.configure do
  # Verifies that versions and hashed value of the package contents in the project's package.json
  config.webpacker.check_yarn_integrity = false
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Attempt to read encrypted secrets from `config/secrets.yml.enc`.
  # Requires an encryption key in `ENV["RAILS_MASTER_KEY"]` or
  # `config/secrets.yml.key`.
  config.read_encrypted_secrets = true

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  # Compress JavaScripts and CSS.
  # config.assets.js_compressor = :uglifier
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # `config.assets.precompile` and `config.assets.version` have moved to config/initializers/assets.rb

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = 'http://assets.example.com'

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = 'X-Sendfile' # for Apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for NGINX

  # Mount Action Cable outside main process or domain
  # config.action_cable.mount_path = nil
  # config.action_cable.url = 'wss://example.com/cable'
  # config.action_cable.allowed_request_origins = [ 'http://example.com', /http:\/\/example.*/ ]
  config.action_cable.allowed_request_origins = [/http:\/\/*/, /https:\/\/*/]

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = ENV['RAILS_FORCE_SSL'].present?

  # Use the lowest log level to ensure availability of diagnostic information
  # when problems arise.
  config.log_level = :debug

  # Prepend all log lines with the following tags.
  config.log_tags = [ :request_id ]

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  Rails.application.routes.default_url_options = {
    protocol: ENV['RAILS_APPLICATION_PROTOCOL'].presence || 'http',
    host: ENV['RAILS_APPLICATION_HOST'].presence || 'example.net',
    port: (ENV['RAILS_APPLICATION_PORT'].presence || '80').to_i,
  }
  # Use a real queuing backend for Active Job (and separate queues per environment)
  # config.active_job.queue_adapter     = :resque
  # config.active_job.queue_name_prefix = "toririn-chat_#{Rails.env}"
  config.action_mailer.perform_caching = false
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = {
    protocol: ENV['RAILS_MAILER_URL_PROTOCOL'].presence,
    host: ENV['RAILS_MAILER_URL_DOMAIN'].presence,
    port: ENV['RAILS_MAILER_URL_PORT'].presence,
  }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: ENV['RAILS_MAILER_SMTP_ADDRESS'].presence || 'localhost',
    port: ENV['RAILS_MAILER_SMTP_PORT'].presence || '25',
    domain: ENV['RAILS_MAILER_SMTP_DOMAIN'].presence || 'localhost',
    user_name: ENV['RAILS_MAILER_SMTP_USER_NAME'].presence,
    password: ENV['RAILS_MAILER_SMTP_PASSWORD'].presence,
    authentication: ENV['RAILS_MAILER_SMTP_AUTHENTICATION'] == 'none' ? nil : ENV['RAILS_MAILER_SMTP_AUTHENTICATION'] || 'plain',
    enable_starttls_auto: ENV['RAILS_MAILER_SMTP_ENABLE_STARTTLS_AUTO'].presence || true,
    openssl_verify_mode: ENV['RAILS_MAILER_SMTP_OPENSSL_VERIFY_MODE'].presence,
    ssl: ENV['RAILS_MAILER_SMTP_SSL'].present?,
    tls: ENV['RAILS_MAILER_SMTP_TLS'].present?,
  }

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Use a different logger for distributed setups.
  # require 'syslog/logger'
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new 'app-name')

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  GA.tracker = ENV['GOOGLE_TRACKING_ID']
end
