#
# Be sure to run `pod lib lint FRCalendarView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FRCalendarView'
  s.version          = '1.1.2'
  s.summary          = 'FRCalendarView is a view to present a calendar'
  s.description      = 'FRCalendarView is a view to present a calendar'

  s.homepage         = 'https://github.com/feliperemigio/calendar-apple'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Wings Development' => 'https://www.wingsdev.com/' }
  s.source           = { :git => 'https://github.com/feliperemigio/calendar-apple.git', :tag => s.version.to_s }
  s.platform     = :ios, '10.3'
  s.swift_version = '4.2'
  s.ios.deployment_target = '10.3'

  s.source_files = 'Classes/**/*.{swift}'
  
end
