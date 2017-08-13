Pod::Spec.new do |spec|

  spec.name         = 'ViewBuilder'
  spec.version      = '0.0.1'
  spec.license      = 'MIT'
  spec.summary      = 'Document based UI framework for iOS'
  spec.homepage     = 'https://github.com/abelsanchezali/ViewBuilder'
  spec.author       = { 'Abel Ernesto Sanchez Ali' => 'abelsanchezali@gmail.com' }
  spec.source       = { :git => 'git://github.com/abelsanchezali/ViewBuilder.git', :tag => spec.version }
  spec.source_files = 'ViewBuilder/ViewBuilder/*.swift'
  spec.requires_arc = true

  spec.ios.deployment_target = '8.0'
  spec.ios.frameworks        = 'Foundation', 'CoreGraphics', 'UIKit'

end

