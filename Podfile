# Uncomment the next line to define a global platform for your project
platform :ios, '12.2'

inhibit_all_warnings!

# Comment the next line if you're not using Swift and don't want to use dynamic frameworks
use_frameworks!

workspace 'Medley-iOS'

def shared_pods
    pod 'RxSwift', '~> 4.0'
    pod 'RxCocoa', '~> 4.0'
end

target 'Medley-iOS' do
  # Pods for Medley-iOS

  shared_pods

  pod 'Alamofire', '~> 5.0.0-beta.6'

  pod 'Swinject'
end

target 'Medley-iOSTests' do
    shared_pods
    inherit! :search_paths
    # Pods for testing

    pod 'OHHTTPStubs/Swift'
    pod 'RxTest'
    pod 'RxBlocking'
end

target 'Medley-iOSUITests' do
    inherit! :search_paths
    # Pods for testing
end
