 Gem::Specification.new do |s|
  s.name        = 'rack-routing'
  s.version     = '0.0.12'
  s.date        = '2019-01-17'
  s.summary     = 'Rack router for your Rack app.'
  s.description = 'Set up routes quickly and easily for a rack app.'
  s.authors     = ['George Ulmer']
  s.email       = 'george@boost-media.com'
  s.files       = ['lib/rack/routing.rb', 'lib/rack/route.rb', 
                   'lib/rack/router.rb', 'lib/rack/shared.rb']
  s.homepage    = 'http://rubygems.org/gems/rack-routing'
  s.license     = 'MIT'
  
  s.add_runtime_dependency 'rack', ['2.0.6']

  s.add_development_dependency 'rspec', ['3.2']
  s.add_development_dependency 'rack-test', ['0.6.2']
  s.add_development_dependency 'guard', ['2.12']
  s.add_development_dependency 'guard-rspec', ['4.5']
end