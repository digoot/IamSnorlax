# Uncomment the next line to define a global platform for your project
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '13.0'

# ignore all warnings from all dependencies
inhibit_all_warnings!

target 'IamSnorlax' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for IamSnorlax

  # LINT libraries
  pod 'SwiftLint'

  # Network libraries
  pod 'Alamofire'

  # Reactive libraries
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxDataSources'

  # Image libraries
  pod 'Kingfisher'
  
  # Constraints libraries
  pod 'SnapKit'

  # Loggers libraries
  pod 'SwiftyBeaver'

  target 'IamSnorlaxTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'RxBlocking'
    pod 'RxTest'
    pod 'Quick'
    pod 'Nimble'
    pod 'Cuckoo'
    pod 'OHHTTPStubs/Swift'
  end

  target 'IamSnorlaxUITests' do
    # Pods for testing
  end

end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      end
    end
end
