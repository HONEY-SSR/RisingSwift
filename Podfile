source 'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git'

platform :ios, '11.0'

target 'RisingSwift' do
	use_frameworks!

	pod 'SwiftySwift'

	target 'RisingSwiftTests' do
		inherit! :search_paths
	end

	target 'RisingSwiftUITests' do
	end

end

post_install do |installer|
	installer.pods_project.build_configurations.each do |config|
		config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
		config.build_settings['VALID_ARCHS'] = 'arm64 arm64e armv7 armv7s x86_64 i386'
		config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
		config.build_settings['HEADER_SEARCH_PATHS'] = '$(PROJECT_DIR)/**'
	end
end