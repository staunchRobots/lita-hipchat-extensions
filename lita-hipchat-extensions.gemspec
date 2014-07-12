Gem::Specification.new do |spec|
  spec.name          = "lita-hipchat-extensions"
  spec.version       = "0.0.1"
  spec.authors       = ["Leonardo Bighetti"]
  spec.email         = ["leonardo.bighetti@staunchrobots.com"]
  spec.description   = %q{Extensions for Hipchat}
  spec.summary       = %q{Extensions for Hipchat}
  spec.homepage      = "https://github.com/staunchRobots/lita-hipchat-extensions"
  spec.license       = "MIT"
  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", ">= 3.3"
  spec.add_runtime_dependency "httparty"
  spec.add_runtime_dependency "activesupport"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 3.0.0"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "pry-byebug"
end
