
Pod::Spec.new do |s|

  s.name         = "ELPickerView"
  s.version      = "0.1.2"
  s.summary      = "Easily Used Picker View build with Swift 3"
  s.description  = <<-DESC
  ELPickerView is an easily used Picker View suit. To use ELPickerView, only three steps (- add -show -hide) is need.
  ELPickerView is flexable too, there are rich document and annotation for ELPickerView.
                   DESC
  s.homepage     = "https://github.com/Elenionl/ELPickerView-Swift"
  s.screenshots  = "https://raw.githubusercontent.com/Elenionl/ELPickerView-Swift/master/screenshots/screenshots_4.gif"
  s.license      = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author             = { "Hanping Xu" => "stellanxu@gmail.com" }
  s.social_media_url   = "https://github.com/Elenionl"
  s.platform     = :ios, '8.0'
  s.source       = { :git => "https://github.com/Elenionl/ELPickerView-Swift.git", :tag => "#{s.version}" }
  s.source_files  = "ELPickerView/ELPickerView/*.swift"
  s.requires_arc = true
  s.frameworks = 'UIKit'
end
# pod spec lint ELPickerView.podspec
# pod trunk push ELPickerView.podspec
