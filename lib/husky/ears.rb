module Husky
  module Ears

    def listen_to(object)
      object.add_listener(responder_class.new(self))
    end

    def responder_class
      "#{controller_name.camelize}Responder".constantize
    end

    def interact(interactor)
      listen_to(interactor)
      yield(interactor) if block_given?
      interactor.run
    end

    def deliver_entities(entities, *options)
      serve_for(entities.map(&:object), *options)
    end

    def deliver_entity(entity, *options)
      serve_for(entity.object, *options)
    end

    private

    def serve_for(target, *options)
      args = { json: target }
      options.each { |option| args.merge!(option) }
      render(args)
    end

  end
end