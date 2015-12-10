Pod::Spec.new do |s|
  s.name             = "LifeEngine"
  s.version          = "0.1.0"
  s.summary          = "Pure text-based adventure game engine."
  s.description      = <<-DESC
  Pure text-based adventure game engine. Basically mocking Lifeline
                       DESC

  s.homepage         = "https://github.com/IslandZero/LifeEngine"
  s.license          = 'MIT'
  s.author           = { "Ryan Guo" => "ryan@islandzero.net" }
  s.source           = { :git => "https://github.com/IslandZero/LifeEngine.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'LifeEngine' => ['Pod/Assets/*.png']
  }
end
