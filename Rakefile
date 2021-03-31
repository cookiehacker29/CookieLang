require 'rake'
require 'colorize'

VERSION = "1.0.0"
PROJECTNAME = "cookielang"
MAINCLASS = "CookieLang"

task :default => [:test, :build]

task :run do 
    puts "- Run of #{PROJECTNAME} !".blue.bold
    sh "./bin/#{PROJECTNAME}"
end

task :build do
    puts "Building in progress...".blue.bold
    puts "- Building of gem".blue.bold
    sh "gem build cookielang.gemspec"
    puts "- Install of gem".blue.bold
    sh "sudo gem install ./#{PROJECTNAME}-#{VERSION}.gem"
    puts "- Creation of bin folder".blue.bold
    sh "mkdir -p bin"
    puts "- Creation of the executable".blue.bold
    sh "touch bin/#{PROJECTNAME}"
    sh "echo \"\#\!/usr/bin/env ruby\n\nrequire '#{PROJECTNAME}'\n#{MAINCLASS}.run\" > bin/#{PROJECTNAME}"
    sh "sudo chmod +x bin/#{PROJECTNAME}"
end

task :clean do
    puts "Cleaning in progress...".blue.bold
    sh "rm -rf bin/"
    sh "rm #{PROJECTNAME}-#{VERSION}.gem"
    sh "rm -rf doc/"
end

task :test do
    puts "- Test of Latex class".blue.bold
    ruby "test/TestLatex.rb"
end

task :doc do
    sh "rdoc --main README.md"
end