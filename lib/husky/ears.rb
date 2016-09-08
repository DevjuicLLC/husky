module Husky
  module Ears

    def listen_to(object)
      object.add_listener(responder_class.new(self))
    end

    def responder_class
      raise "Rails is not running" unless defined?(Rails)
      "#{controller_name.camelize}Responder".constantize
    end

    def husky_responder
      responder_class.new(self)
    end

    def interact(interactor)
      yield(interactor) if block_given?
      interactor.add_listener(husky_responder)
      interactor.run
    end

    # DEPRECATE --> Build out custom entity serialization!
    # This introduces a dependency on ActiveModelSerializers
    def deliver_entities(entities, *options)
      raise "Rails is not running" unless defined?(Rails)
      serve_for(entities.map(&:data), *options)
    end

    def deliver_entity(entity, *options)
      raise "Rails is not running" unless defined?(Rails)
      serve_for(entity.data, *options)
    end

    private

    def serve_for(target, *options)
      args = { json: target }
      options.each { |option| args.merge!(option) }
      render(args)
    end

  end
end