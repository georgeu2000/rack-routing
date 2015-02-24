 Gem::Specification.new do |s|
  s.name        = 'rack-routes'
  s.version     = '0.0.2'
  s.date        = '2015-02-23'
  s.summary     = 'Rack router for your Rack app.'
  s.description = 'Set up routes quickly and easily for a rack app.'
  s.authors     = ['George Ulmer']
  s.email       = 'george@iamplus.com'
  s.files       = ['lib/rack/routes.rb', 'lib/rack/route.rb', 'lib/rack/router.rb']
  s.homepage    = 'http://rubygems.org/gems/rack-routes'
  s.license     = 'MIT'
  s.add_development_dependency 'rspec', ['>= 3.2']
end