require 'husky/broadcaster'

module Husky

  class Interactor
    include Husky::Broadcaster

    class << self

      def run(*args)
        new(*args).tap { |interactor| interactor.run }
      end

    end

    def run
      raise NotImplementedError
    end
  end

end