Pod::Spec.new do |s|
  s.name = 'SPPatternLock'
  s.version = '2.0.2'
  s.license = { :type => 'MIT', :file => 'LICENSE'  }
  s.summary = 'Simple and elegant Pattern Lock for iOS'
  s.social_media_url = 'http://twitter.com/iosCook'
  s.homepage  = 'https://github.com/freesuraj/SPPatternLock'
  s.authors = { 'Suraj Pathak' => 'freesuraj@gmail.com' }
  s.source = { :git => 'https://github.com/freesuraj/SPPatternLock.git', :tag => s.version }
  s.ios.deployment_target = '9.0'
  s.source_files = 'Sources/*swift'
end