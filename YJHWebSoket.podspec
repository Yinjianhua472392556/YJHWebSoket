#
# Be sure to run `pod lib lint YJHWebSoket.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YJHWebSoket'
  s.version          = '0.1.2'
  s.summary          = 'YJHWebSoket is a wrapper of websoket'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.homepage         = 'https://github.com/Yinjianhua472392556/YJHWebSoket'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Yinjianhua472392556' => '18620526218@163.com' }
  s.source           = { :git => 'https://github.com/Yinjianhua472392556/YJHWebSoket.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'YJHWebSoket/Classes/**/*'
  
  # s.resource_bundles = {
  #   'YJHWebSoket' => ['YJHWebSoket/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.frameworks = 'UIKit', 'Foundation'
  s.dependency 'MJExtension'
  s.dependency 'FMDBDataTable'
  s.dependency 'SocketRocket'
  s.dependency 'AFNetworking'
end
