require 'rails/generators'

module Husky
  class InstallGenerator < Rails::Generators::Base

    desc "Sets up directories for Husky workflow."

    def create_new_directories
      empty_directory "app/responders"
      empty_directory "app/interactors"
    end

    def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'templates')
    end

  end
end