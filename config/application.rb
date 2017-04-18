require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Odin
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
	
    # Where the I18n library should search for translation files
	I18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}')]
	 
	# Set default locale to something other than :en
	I18n.default_locale = :pt

  config.time_zone = 'America/Campo_Grande'
  end
end
