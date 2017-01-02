# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/tarball_scm/version'

Gem::Specification.new do |spec|
  spec.name          = 'capistrano-tarball_scm'
  spec.version       = Capistrano::TarballScm::VERSION
  spec.authors       = ['Artem Chistyakov']
  spec.email         = ['chistyakov.artem@gmail.com']

  spec.summary       = %q{Create and deploy tarballs via Capistrano}
  spec.homepage      = 'https://github.com/temochka/capistrano-tarball_scm'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split('\x0').reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
