#!/usr/bin/env ruby
require 'pathname'

Dir.glob(File.expand_path("~/.rbenv/versions/*")).each do |v|
  system "rbenv install #{Pathname(v).basename.to_s} --force"
  gem_cmd = "#{v}/bin/gem"
  system "#{gem_cmd} update --system"
  system "yes | #{gem_cmd} update"
  system "yes | #{gem_cmd} cleanup"
end
