module Husky
  class Repo

    class << self

      def find(id)
        entity.new(data_source.find(id))
      end

      def all
        entity.wrap(data_source)
      end

      def build(attributes)
        entity.new(data_source.build(attributes))
      end

      def create(attributes)
        entity.new(data_source.create(attributes))
      end

      def update(item, attributes)
        entity.new(item.update_attributes(attributes))
      end

      def save(item)
        item.save
      end

      def destroy(item)
        item.destroy
      end

      private

      def data_sourse
        raise NotImplementedError
      end

      def entity
        raise NotImplementedError
      end

    end

  end
end