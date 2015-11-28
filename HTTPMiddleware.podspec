Pod::Spec.new do |s|
  s.name = 'HTTPMiddleware'
  s.version = '0.1'
  s.license = 'MIT'
  s.summary = 'HTTP middleware framework for Swift 2 (Linux ready)'
  s.homepage = 'https://github.com/Zewo/HTTPMiddleware'
  s.authors = { 'Paulo Faria' => 'paulo.faria.rl@gmail.com' }
  s.source = { :git => 'https://github.com/Zewo/HTTPMiddleware.git', :tag => s.version }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'

  s.source_files = 'HTTPMiddleware/**/*.swift'
  s.dependency 'HTTP'

  s.requires_arc = true
end