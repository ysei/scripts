#!/usr/bin/env ruby

[Dir.glob('*') + Dir.glob('*/*')].flatten.each do |dir|
  next unless File.directory? dir
  Dir.chdir(dir) do
    next unless File.directory?('.git')
    remote = `git remote -v`.chomp
    if match = remote.match(/git:\/\/[^ ]*/)
      `git remote set-url origin #{match.to_s.gsub(/git:/, "https:")}`
    end
    p dir
    `git reset --hard`
    `git clean -fd`
    if dir.include?('rubysl')
      `git checkout 2.0`
    else
      `git checkout master`
    end
    `git remote prune origin`
    `git pull --rebase`
  end
end
