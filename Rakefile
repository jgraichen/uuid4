# frozen_string_literal: true

require 'rake/release/task'
require 'rspec/core/rake_task'

task default: :spec

RSpec::Core::RakeTask.new(:spec)

Rake::Release::Task.new do |spec|
  spec.sign_tag = true
end
