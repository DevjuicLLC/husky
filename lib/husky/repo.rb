module Husky

  module Repo

    class ActiveRecord

      def all
        entity.wrap(data_source.all)
      end

      def find(id)
        entity.build(data_source.find(id))
      end

      def new(attributes = {})
        entity.build(data_source.new(attributes))
      end

      # DEPRECATE
      def build(attributes)
        entity.build(data_source.build(attributes))
      end

      def save(item)
        item.save
      end

      def create(attributes)
        entity.build(data_source.create(attributes))
      end

      def update(item, attributes)
        entity.build(item.update_attributes(attributes))
      end

      def destroy(item)
        item.destroy
      end

      private

      def data_source
        raise NotImplementedError
      end

      def entity
        raise NotImplementedError
      end

    end

    class InMemory

      def initialize
        @records = {}
        @id      = 1
      end

      def all
        @records.map { |key, value| value }
      end

      def new(attributes = {})
        entity.build(data_source.new(attributes))
      end

      def find(id)
        entity.build(get_record(id))
      end

      def get_record(id)
        @records[id.to_i]
      end

      def save(original_entity)
        object = original_entity.data
        object.id = @id
        object.update_attributes({ id: @id })
        @records[@id] = object
        @id += 1
        entity.build(object)
      end

      def create(attributes = {})
        save(new(attributes))
      end

      def update(item, attributes)
        entity.build(item.update_attributes(attributes))
      end

      def destroy(object)
        @records.delete(object.id)
      end

      private

      def data_source
        raise NotImplementedError
      end

      def entity
        raise NotImplementedError
      end

    end

    class Registry

      class << self

        def register(type, repo)
          repositories[type] = repo
        end

        def repositories
          @repositories ||= {}
        end

        def for(type)
          repositories[type]
        end

      end

    end

  end

end