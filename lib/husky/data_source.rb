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
            Husky::DataSource::MemoryRelation.new(set, self, repo)
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

    class MemoryRelation
      include Enumerable

      attr_reader :set, :caller, :receiver

      def initialize(set, caller, receiver)
        @set      = set
        @caller   = caller
        @receiver = receiver
      end

      def each
        set.map { |item| yield item }
      end

      def new(attributes)
        receiver.new({"#{caller.class.to_s.split('::').last.downcase}_id".to_sym => caller.id })
      end

      def create(attributes)
        receiver.create({"#{caller.class.to_s.split('::').last.downcase}_id".to_sym => caller.id })
      end

    end

  end

end