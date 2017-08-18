Pod::Spec.new do |spec|

  spec.name         = 'ViewBuilder'
  spec.version      = '0.0.2'
  spec.license      = 'MIT'
  spec.summary      = 'Document based UI framework for iOS'
  spec.homepage     = 'https://github.com/abelsanchezali/ViewBuilder'
  spec.author       = { 'Abel Ernesto Sanchez Ali' => 'abelsanchezali@gmail.com' }
  spec.source       = { :git => 'https://github.com/abelsanchezali/ViewBuilder.git', :tag => spec.version.to_s }
  spec.source_files = 'Source/**/*.swift'
  spec.requires_arc = true

  spec.ios.deployment_target = '8.0'
  spec.ios.frameworks        = 'Foundation', 'CoreGraphics', 'UIKit'

  spec.tvos.deployment_target = '9.0'
  spec.tvos.frameworks        = 'Foundation', 'CoreGraphics', 'UIKit'

end

