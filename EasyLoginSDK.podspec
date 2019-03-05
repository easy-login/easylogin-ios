Pod::Spec.new do |s|
  s.name = 'EasyLoginSDKTest'
  s.version = '0.0.1'
  s.license = 'MIT'
  s.summary = 'Elegant HTTP Networking in Swift'
  s.homepage = 'https://github.com/vinhdn/EasyLoginSDK'
  s.social_media_url = 'http://twitter.com/vinhdn07'
  s.authors = { 'Vinhdn' => 'vinhdn07@gmail.com' }
  s.source = { :git => 'https://github.com/vinhdn/EasyLoginSDK.git', :tag => s.version }
  s.documentation_url = 'https://github.com/vinhdn/EasyLoginSDK'

  s.ios.deployment_target = '10.0'

  s.source_files = 'Source/*.swift'
end