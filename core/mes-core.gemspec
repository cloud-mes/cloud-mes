version = File.read(File.expand_path('../../MES_VERSION', __FILE__)).strip

Gem::Specification.new do |s|
  s.name        = 'mes-core'
  s.version     = version
  s.authors     = ['Eric Guo']
  s.email       = ['eric@cloud-mes.com']
  s.homepage    = 'http://www.cloud-mes.com/'
  s.summary     = 'The bare bones necessary for Cloud-MES.'
  s.description = 'The bare bones necessary for Cloud-MES.'
  s.license     = 'BSD-3'

  s.files = Dir['{app,config,lib}/**/*', 'Rakefile', 'LICENSE.MD']
  s.require_path = 'lib'

  s.add_dependency 'pundit', '~> 1.0'

  s.add_development_dependency 'sqlite3'
end
