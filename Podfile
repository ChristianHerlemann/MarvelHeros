use_frameworks!
inhibit_all_warnings!

platform :ios, '15.0'

def shared_pods
    pod 'SwiftLint'
end

target 'Marvel' do
    shared_pods
end

target 'Heros' do
    shared_pods
end

target 'Shared' do
    shared_pods
end

target 'Networking' do
    shared_pods
end

target 'MarvelTests' do
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '5'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
    end
  end
end
