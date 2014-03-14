require 'bundler/gem_tasks'
require 'code_press'

task :perceus do
  src = CodePress::Source.new 'http://mirror.infiscale.com/perceus/source/',
                              /^perceus-([\d\.]+)\.tar\.gz$/,
                              /[\d\.]*\d/

  dest = CodePress::Destination.new '/tmp/perceus/'

  CodePress.procedure(src, dest)
end
