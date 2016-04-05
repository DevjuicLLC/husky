module Husky

  module DataSource

    class InMemory

      attr_reader :attributes
      attr_accessor :id

      def initialize(attributes)
        @attributes = attributes
      end

      def update_attributes(attrs)
        @attributes.each do |key, value|
          if attrs.key?(key)
            @attributes[key] = attrs[key]
          end
        end
      end

    end

  end

end