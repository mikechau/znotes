
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "znotes/version"

Gem::Specification.new do |spec|
  spec.name          = "znotes"
  spec.version       = Znotes::VERSION
  spec.authors       = ["Mike Chau"]
  spec.email         = ["mikechau@users.noreply.github.com"]

  spec.summary       = %q{Developer notebook helper.}
  spec.description   = %q{znotes generates notebook entries.}
  spec.homepage      = "https://github.com/mikechau/znotes"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry-byebug", "~> 3.5.1"
  spec.add_development_dependency "awesome_print", "~> 1.8.0"
  spec.add_development_dependency "timecop", "~> 0.9.1"
end
