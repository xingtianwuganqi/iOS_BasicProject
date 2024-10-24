#
#  Be sure to run `pod spec lint BasicProject.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "SwiftUIBasic"
  spec.version      = "0.0.1"
  spec.summary      = "SwiftUI basic"

  spec.description  = <<-DESC
  ios basic demo,use for lovecat
                   DESC

  spec.homepage     = "https://github.com/xingtianwuganqi/swiftui-basic.git"

  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.swift_versions = ['5.0', '5.1', '5.2', '5.3']
  
  spec.author       = { "jingjun" => "rxswift@126.com" }
  
  spec.platform     = :ios, "13.0"

  spec.source       = { :git => "https://github.com/xingtianwuganqi/swiftui-basic.git", :tag => "#{spec.version}" }
  spec.source_files = "BasicProject/Common/*.swift", "BasicProject/Extension/*.swift"
  spec.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }

  spec.frameworks   = ["Foundation","Photos"]
  
  spec.ios.dependency 'MBProgressHUD'
  spec.ios.dependency 'ReachabilitySwift'
  spec.ios.dependency 'RxSwift'
  spec.ios.dependency 'Moya/RxSwift'
  spec.ios.dependency 'HandyJSON'

end
