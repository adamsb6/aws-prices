# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "aws-prices"
  s.version     = '0.1'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Brandon Adams"]
  s.email       = ["brandon.adams@me.com"]
  s.homepage    = "http://github.com/adamsb6/aws-prices"
  s.summary     = "Retrives on-demand prices for EC2 instances"
  s.description = "Scrapes Amazon-served JSON documents, providing an easy interface for programmers."

  s.rubyforge_project = "aws-prices"

  s.rdoc_options = ["--title", "aws-prices documentation", "--line-numbers", "--main", "README"]
  s.extra_rdoc_files = [
  ]

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_path = 'lib'
end