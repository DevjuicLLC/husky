module Husky

  class Entity

    class << self

      def wrap(items)
        items.map { |item| build(item) }
      end

      def build(data = nil)
        instance = allocate
        instance.construct(data)
        instance
      end

    end

    attr_reader :data

    def construct(data)
      if data.nil?
        # do nothing
      elsif data.is_a? Hash
        data.each_pair do |key, value|
          instance_variable_set("@#{key}", value)
        end

        data.each_pair do |key, value|
          self.class.send(:define_method, key) do
            instance_variable_get("@#{key}")
          end
        end
      else
        @data = data
      end
    end

    def set_basic_attributes_from_hash(hash)
      hash.each_pair do |key, value|
        unless value.respond_to? :each
          instance_variable_set("@#{key}", value)
        end
      end

      hash.each_pair do |key, value|
        unless value.respond_to? :each
          self.class.send(:define_method, key) do
            instance_variable_get("@#{key}")
          end
        end
      end
    end

    def method_missing(method, *args, &block)
      raise "#{method} called on @data, but @data is nil." if data.nil?
      data.send(method, *args, &block)
    end

  end

end