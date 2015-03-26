require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Votogenic
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de


    ### Custom app configuration below

    # Config parameters can be accessed with
    # e.g. Rails.configuration.voting.default_expiration

    # voting
    config.x.voting.default_expiration = 90 # days
    config.x.voting.fraud_array_size = 250


    # user
    # default user limits
    config.x.user.default_allowed_friends = 100

    # image size configuration
    config.x.image.sizes = {
      :xxs      => ['50x50>',  :jpg],
      :xs       => ['100x100>',  :jpg],
      :s        => ['250x250>',  :jpg],
      :m        => ['500x500>',  :jpg],
      :l        => ['1024x1024>',  :jpg],
      :xl       => ['1920x1600>',  :jpg]
    }

    # amazon s3 configuration
    config.x.s3.credentials = {
        :bucket => 'votogenic', 
        :access_key_id => "AKIAIYH2ZUYDSBJDCNRA", 
        :secret_access_key => "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"
    }
  end
end