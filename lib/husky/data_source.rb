# Axe this
module Husky

  module DataSource

    class InMemory

      class << self

        def has_many(association)
          define_method association do
            singular_association = association.to_s[0..-2].to_sym
            klass_id = "#{self.class.name.split('::')[1].downcase}_id".to_sym
            repo = Husky::Repo::Registry.for(singular_association)
            set = repo.all.select { |k,v| v.send(klass_id) == self.id }
            receiving_class = repo.class.to_s[0..-5].split('::').reduce(Module, :const_get)
            Husky::DataSource::MemoryRelation.new(set, self, receiving_class)
          end
        end

      end

      attr_reader :attributes
      attr_accessor :id

      def initialize(attributes)
        @attributes = attributes
      end

      def update_attributes(attrs)
        attrs.each do |key, value|
          @attributes[key] = attrs[key]
        end
      end

    end

    class MemoryRelation
      include Enumerable

      attr_reader :set, :caller, :receiving_class

      def initialize(set, caller, receiving_class)
        @set             = set
        @caller          = caller
        @receiving_class = receiving_class
      end

      def each
        set.map { |item| yield item }
      end

      def new(attributes)
        attrs = attributes
        attrs[caller_id] = caller.id
        receiving_class.new(attrs)
      end

      def caller_id
        "#{caller.class.to_s.split('::').last.downcase}_id".to_sym
      end

    end

  end

end