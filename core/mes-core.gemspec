version = File.read(File.expand_path('../../MES_VERSION', __FILE__)).strip

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'mes-core'
  s.version     = version
  s.summary     = 'The bare bones necessary for Cloud-MES.'
  s.description = 'The bare bones necessary for Cloud-MES.'

  s.required_ruby_version     = '>= 2.1.0'
  s.required_rubygems_version = '>= 1.8.23'

  s.author      = 'Eric Guo'
  s.email       = 'eric@cloud-mes.com'
  s.homepage     = 'http://www.cloud-mes.com'
  s.license      = 'BSD-3'

  s.files        = Dir['LICENSE.md', 'README.md', 'lib/**/*']
  s.require_path = 'lib'
end
