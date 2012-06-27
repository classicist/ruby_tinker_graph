require 'rubygems'
require 'rake/gempackagetask'

spec = Gem::Specification.new do |s| 
  s.name = "tinker_graph"
  s.version = "0.0.1"
  s.date = %q{2010-06-01}  
  s.author = "Paul Saieg"
  s.email = %q{paul.saieg @noSpamAt g-ee-mail.com}
  s.platform = Gem::Platform::RUBY
  s.summary = %q{A simple, elegant in-memory Property Graph which implements TinkerPop's Blueprints}
  s.files = FileList["{bin,lib, lib/tinker_graph}/**/*"].to_a
  s.require_path = "lib"
  s.autorequire = "name"
  s.test_files = FileList["{spec}/**/*.spec"].to_a
  s.has_rdoc = false
  s.signing_key = '/Users/paul/.ssh/gem-private_key.pem'
end
 
Rake::GemPackageTask.new(spec) do |pkg| 
  pkg.need_tar = true 
end