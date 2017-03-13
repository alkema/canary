require 'dotenv'
Dotenv.load

# Standard library
require 'pathname'

# Libraries
require 'virtus'
require 'rspec'

# Gem
require 'callable'

require 'canary/version'
require 'canary/config'
require 'canary/rspec_formatter'
require 'canary/runner'
require 'canary/exception'
require 'canary/example'
require 'canary/summary'
require 'canary/run'

require 'canary/notifiers'
require 'canary/notifiers/slack'
require 'canary/notifiers/slack_attachment'
require 'canary/notifiers/cloud_watch'
require 'canary/notifiers/cloud_watch_metric_data'

# Root library module
module Canary

  ROOT_PATH = Pathname.new(File.expand_path('..', __dir__))

  SPEC_PATH = Pathname.new('lib/canary/spec')
  FULL_SPEC_PATH = ROOT_PATH.join(SPEC_PATH)

  VENDOR_SPEC_PATH = Pathname.new('./spec')
  VENDOR_SPEC_PATH_REGEX = %r{#{VENDOR_SPEC_PATH}/(\w+)/\w+}

  WAIT_TIME = 30

  class << self

    def app_names
      @app_names ||=
        VENDOR_SPEC_PATH.children.
        select(&:directory?).collect do |app|
          app.basename.to_s
        end
    end

    def apps
      app_names.map do |app|
        OpenStruct.new(
          name: app,
          url: Canary.config.fetch("#{app}_url"),
          cluster: Canary.config.fetch("#{app}_cluster")
        )
      end
    end

  end

end
