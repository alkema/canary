# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'canary/version'

# rubocop:disable Metrics/BlockLength
Gem::Specification.new do |spec|
  spec.name = 'canary'
  spec.version = Canary::VERSION
  spec.authors = ['Jody Alkema']
  spec.email = ['jody@alkema.ca']

  spec.summary = 'Rspec for monitoring'
  spec.description = 'Canary is a library that makes it simple to write Capybara feature tests' \
  'for any website that can be used for monitoring. The output from an Rspec run can then be' \
  'used for notifications etc. Currently Slack and AWS CloudWatch are supported.'
  spec.homepage = 'https://github.com/alkema/canary'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # Note: Will have to rename project before publishing to RubyGems, a `canary` exists...
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.license = 'MIT'

  spec.files =
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(spec|features)/})
    end

  spec.require_paths = ['lib']
  spec.executables = ['canary']

  spec.add_runtime_dependency 'aws-sdk'
  spec.add_runtime_dependency 'capybara'
  spec.add_runtime_dependency 'dotenv'
  spec.add_runtime_dependency 'poltergeist'
  spec.add_runtime_dependency 'slack-notifier'
  spec.add_runtime_dependency 'virtus'
  spec.add_runtime_dependency 'rspec', '3.9.0'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'climate_control'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '3.9.0'
end
