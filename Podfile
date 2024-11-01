source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '14.0'

target 'BasicProject' do
  use_frameworks!
  pod 'MBProgressHUD'
  pod 'SDWebImage'
  pod 'ReachabilitySwift'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Moya/RxSwift'
#  pod 'HandyJSON'
  pod 'ESTabBarController-swift'
  pod 'HBDNavigationBar', '~> 1.9.4'
  pod 'MJRefresh'
  pod 'URLNavigator'
  pod 'DZNEmptyDataSet'
  pod 'SnapKit'
  pod 'ReactorKit'
  pod 'SmartCodable'
end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
       end
    end
  end
end
