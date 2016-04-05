module Husky
end

require 'generators/install_generator'
require 'generators/uninstall_generator'
require 'husky/ears'
require 'husky/interactor'
require 'husky/responder'
require 'husky/repo'
require 'husky/entity'
require 'husky/data_source'

ActionController::Base.class_eval do
  include Husky::Ears
end

