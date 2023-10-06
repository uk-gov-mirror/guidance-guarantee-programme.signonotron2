# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)
ENV['SUPPRESS_JASMINE_DEPRECATION'] = 'true'

require 'bundler/setup' if File.exist?(ENV['BUNDLE_GEMFILE'])
