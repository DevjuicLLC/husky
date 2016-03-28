require 'delegator'

module Husky

  class Entity < SimpleDelegator

     class << self

      def wrap(items)
        items.map { |item| new(item) }
      end

    end

    attr_reader :object

    def initialize(object)
      @object = object
      super
    end

  end

end