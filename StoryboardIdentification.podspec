#
#  Be sure to run `pod spec lint StoryboardIdentification.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "StoryboardIdentification"
  s.version      = "0.1.1"
  s.summary      = "Easy access ViewControllers on your storyboards"

  s.description  = <<-DESC
  Tool which allows you easy acceess your storyboards and instaniate view controllers by autoupdated constants
                   DESC

  s.homepage     = "https://github.com/utiko/StoryboardIdentification"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  #s.license      = "MIT"
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  s.author             = { "uTiko" => "tiko@utiko.net" }
  # s.social_media_url   = "http://twitter.com/kostia.kolesnyk"

  # s.platform     = :ios
  s.platform     = :ios, "9.0"
  s.swift_version = "4.2"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"


  s.source       = { :git => "https://github.com/utiko/StoryboardIdentification.git", :tag => "0.1.1" }
  s.source_files  = "StoryboardIdentification", "StoryboardIdentification/**/*"
  # s.exclude_files = "Classes/Exclude"

 #  s.prepare_command = <<-CMD
	# path_to_project = "${SOURCE_ROOT}/${PROJECT_NAME}.xcodeproj"
	# project = Xcodeproj::Project.open(path_to_project)
	# main_target = project.targets.first
	# phase = main_target.new_shell_script_build_phase("Refresh Storyboards Data")
	# phase.shell_script = "${PODS_ROOT}/StoryboardIdentification/RefreshStoryboardsData.sh"
	# project.save()  
	# CMD

  # s.public_header_files = "Classes/**/*.h"
  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  s.preserve_paths = "*"

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  # s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
