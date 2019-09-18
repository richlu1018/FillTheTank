Pod::Spec.new do |s|
  s.name             = 'FillTheTank'
  s.version          = '1.0.1'
  s.summary          = 'A customizable container view with options for filling up animation.'
 
  s.description      = <<-DESC
This FillTheTank view will fills up with your custom color linearly or progressively with several other custom options!
                       DESC
  
  s.swift_versions  = '4.0'
  s.homepage         = 'https://github.com/richlu1018/FillTheTank'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Richard Lu' => 'richlu1018@gmail.com' }
  s.source           = { :git => 'https://github.com/richlu1018/FillTheTank.git', :tag => 'v1.0.1' }
 
  s.ios.deployment_target = '11.0'
  s.source_files = 'FillTheTank/TankView.swift', 'FillTheTank/FillUpManager.swift', 'FillTheTank/FillsView.swift'
 
end