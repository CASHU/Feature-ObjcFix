Pod::Spec.new do |s|


# 1
s.platform = :ios
s.ios.deployment_target = '9.0'
s.name = "CASHUTEST"
s.summary = "CASHU SDK allows you to integrate your project with CASHU internal services"
s.requires_arc = true

# 2
s.version = "1.0.0"

# 3
s.license = { :type => "MIT"}

# 4 - Replace with your name and e-mail address
s.author = { "CASHU" => "s.help@cashu.com" }

# 5 - Replace this URL with your own Github page's URL (from the address bar)
s.homepage = "https://github.com/CASHU/CASHU-SDK"


# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = = { :git => "https://github.com/CASHU/Feature-ObjcFix.git", :branch => "master" , :tag => s.version.to_s }

# 7
s.framework = "UIKit"
s.dependency 'CCMPopup'
s.dependency 'SCrypto'

# 8
s.source_files = "CASHU/**/*.{swift}"
#s.exclude_files = "CASHU/Private/**/*.{swift}"

# 9
s.resources = "CASHU/**/*.{png,jpeg,jpg,storyboard,xib,ttf,plist,xcassets}"

#10
s.swift_version = "4.1"

end
