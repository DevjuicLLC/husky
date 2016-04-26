require 'forwardable'

module Husky

  class Entity
    extend Forwardable

    class << self

      def fields(*field_names)
        field_names.each do |field_name|
          def_delegators :_data, field_name
          def_delegators :_data, "#{field_name}="
        end
      end

      def wrap(items)
        items.map { |item| new(item) }
      end

    end

    attr_reader :_data

    def initialize(_data)
      @_data = _data
    end

  end

end