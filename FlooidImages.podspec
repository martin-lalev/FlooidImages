Pod::Spec.new do |s|

s.name         = "FlooidImages"
s.version      = "0.0.9"
s.summary      = "Image loading framework"
s.description  = "Image loading framework"
s.homepage     = "http://github.com/martin-lalev/FlooidImages"
s.license      = "MIT"
s.author       = "Martin Lalev"
s.platform     = :ios, "13.0"
s.source       = { :git => "https://github.com/martin-lalev/FlooidImages.git", :tag => s.version }
s.source_files  = "FlooidImages", "FlooidImages/**/*.{swift}"
s.swift_version = '6.0'

end
