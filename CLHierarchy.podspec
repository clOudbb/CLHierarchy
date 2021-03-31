Pod::Spec.new do |s|
  s.name = 'CLHierarchy'
  s.version = '1.0.0'

  s.ios.deployment_target = '9.0'

  s.license = 'MIT'
  s.summary = 'A view management tool, including tree structure management'
  s.homepage = 'https://github.com/clOudbb/CLHierarchy'
  s.author = { 'clOudbb' => 'z61723117@gmail.com' }
  s.source = { :git=> '', :tag => s.version.to_s}

  #s.source = { :git => 'https://github.com/clOudbb/CLHierarchy', :tag => s.version.to_s }

  s.description = 'A view management tool, including tree structure management'
  s.requires_arc = true
  s.frameworks = 'UIKit', 'XCTest'
  s.source_files = 'CLHierarchy/**/*.{h,m}'
  s.public_header_files = 'CLHierarchy/**/*.{h}'
  
end
