# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mina/db_sync/version'

Gem::Specification.new do |spec|
  spec.name          = "mina-db_sync"
  spec.version       = Mina::DbSync::VERSION
  spec.authors       = ["Jason Floyd"]
  spec.email         = ["jason.floyd@camfil.com"]

  spec.summary       = %q{Sync database tables between production & development using mina.}
  spec.description   = ''
  spec.homepage      = 'https://github.com/floydj/mina-db_sync'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'mina', '>= 1.0.6'
  spec.add_dependency 'rake', '>= 10.0'
  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rspec", "~> 3.0"
end
