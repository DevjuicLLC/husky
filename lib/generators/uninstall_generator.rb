require 'rails/generators'

module Husky
  class UninstallGenerator < Rails::Generators::Base

    desc "Sets up directories for Husky workflow."

    def create_new_directories
      Dir.delete "app/responders"
      Dir.delete "app/interactors"
      Dir.delete "app/entities"
    end

    def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'templates')
    end

  end
end