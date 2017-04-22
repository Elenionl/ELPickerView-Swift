
Pod::Spec.new do |s|

  s.name         = "ELPickerView"
  s.version      = "0.1.0"
  s.summary      = "A Picker View with animation build in Swift 3"
  s.description  = <<-DESC
  ELPickerView is an easily used Picker View suit. To use ELPickerView, only three steps (- add -show -hide) is need.
  ELPickerView is flexable too, there are rich document and annotation for ELPickerView.
                   DESC
  s.homepage     = "https://github.com/Elenionl/ELPickerView-Swift"
  s.screenshots  = "https://raw.githubusercontent.com/Elenionl/ELPickerView-Swift/master/screenshots/screenshots_2.png", "https://raw.githubusercontent.com/Elenionl/ELPickerView-Swift/master/screenshots/screenshots_1.png"
  s.license      = "MIT"
  s.author             = { "Elenionl" => "stellanxu@gmail.com" }
  s.social_media_url   = "https://github.com/Elenionl"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Elenionl/ELPickerView-Swift.git", :tag => "#{s.version}" }
  s.source_files  = "ELPickerView/ELPickerView/*.swift"
  s.requires_arc = true
end
