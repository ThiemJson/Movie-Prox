# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

def pods
  pod 'Alamofire','5.6.4'
  pod 'SwiftyJSON','5.0.1'
  pod 'IQKeyboardManagerSwift','6.5.11'
  pod 'SVProgressHUD','2.2.5'
  pod 'SDWebImage'
  pod 'Toast-Swift','5.0.1'
  pod 'NVActivityIndicatorView','5.1.1'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxLocalizer'
  pod 'Charts'
  pod 'RxGesture'
  pod 'SwiftMessages','9.0.6'
  pod 'RxDataSources'
  pod 'ReachabilitySwift','5.0.0'
  pod 'FSPagerView'
  pod "ViewAnimator"
  pod 'YouTubePlayer'
  pod 'Google-Mobile-Ads-SDK'
end

target 'movie' do
  use_frameworks!
  pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
