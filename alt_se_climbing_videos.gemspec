# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'alt_se_climbing_videos/version'

Gem::Specification.new do |spec|
  spec.name          = "alt_se_climbing_videos"
  spec.version       = AltSeClimbingVideos::VERSION
  spec.authors       = ["'Liah Wallace'"]
  spec.email         = ["'liahwallace1@gmail.com'"]

  spec.summary       = "Southeast bouldering video aggregator."
  spec.description   = "The Southeast Climbing Videos gem will help you find the newest videos uploaded Youtube for your favorite Southeast Bouldering spot by providing a list of videos by location and upload date."
  spec.homepage      = "https://github.com/liahwallace1/alt_se_climbing_videos"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
#  if spec.respond_to?(:metadata)
#    spec.metadata['allowed_push_host'] = "#TODO: Set to 'http://mygemserver.com'"
  #else
  #  raise "RubyGems 2.0 or newer is required #to protect against " \
#      "public gem pushes."
#  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry", ">=0"
  spec.add_development_dependency "rspec", ">=0"
  spec.add_dependency "nokogiri", ">=0"
  spec.add_dependency "colorize", ">=0"
end
