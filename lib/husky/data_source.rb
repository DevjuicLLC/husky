module Husky

  module DataSource

    class InMemory

      class << self

        def has_many(association)
          define_method association do
            singular_association = association.to_s[0..-2].to_sym
            klass_id = "#{self.class.name.split('::')[1].downcase}_id".to_sym
            Repository.for(singular_association).all.select { |k,v| v.send(klass_id) == self.id }
          end
        end

      end

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