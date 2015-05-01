Pod::Spec.new do |s|
  s.name = 'XBot'
  s.version = '0.0.1'
  s.license = 'MIT'
  s.summary = 'Xcode Bot Server Wrapper'
  s.homepage = 'https://github.com/modcloth-labs/XBot'
  s.source = { :git => 'https://github.com/twg/XBot.git', :tag => s.version }
  s.authors = { 'Geoff Nix' => "" }

  s.osx.deployment_target = '10.10'

  s.source_files = 'XBot/*.swift'
  s.dependency 'Alamofire', '~> 1.2.0'

  s.requires_arc = true
end
