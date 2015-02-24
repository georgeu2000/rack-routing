 Gem::Specification.new do |s|
  s.name        = 'rack-routing'
  s.version     = '0.0.5'
  s.date        = '2015-02-24'
  s.summary     = 'Rack router for your Rack app.'
  s.description = 'Set up routes quickly and easily for a rack app.'
  s.authors     = ['George Ulmer']
  s.email       = 'george@boost-media.com'
  s.files       = ['lib/rack/routing.rb', 'lib/rack/route.rb', 
                   'lib/rack/router.rb', 'lib/rack/shared.rb']
  s.homepage    = 'http://rubygems.org/gems/rack-routes'
  s.license     = 'MIT'
  s.add_development_dependency 'rspec', ['3.2']
  s.add_development_dependency 'rack', ['1.6']
  s.add_development_dependency 'rack-test', ['0.6.2']
  s.add_development_dependency 'guard', ['2.12']
  s.add_development_dependency 'guard-rspec', ['4.5']
end