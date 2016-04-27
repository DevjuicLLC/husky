require 'delegate'

module Husky

  class Entity < SimpleDelegator

    class << self

      def wrap(items)
        items.map { |item| new(item) }
      end

      def new_from_hash(hash)
        raise hash_error(hash) unless hash.is_a? Hash
        instance = allocate
        instance.initialize_from_hash(hash)
        instance
      end

      private

      def hash_error(hash)
        "Entity#initialize_from_hash expects a hash as an argument, and you provided a #{hash.class.name} (#=> #{hash})."
      end

    end

    attr_reader :object

    def initialize(object)
      @object = object
      super
    end

    def initialize_from_hash(post_data)
      post_data.each_pair do |key, value|
        instance_variable_set("@#{key}", value)
      end

      post_data.each_pair do |key, value|
        self.class.send(:define_method, key) do
          instance_variable_get("@#{key}")
        end
      end
    end

  end

end