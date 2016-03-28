module Husky
  module Ears

    def listen_to(object, listeners = [])
      klass = "#{controller_name.camelize}Responder".constantize
      default = klass.new(self)
      listeners << default
      listeners.each do |listener|
        object.add_listener(listener)
      end
    end

    def interact(interactor)
      listen_to(interactor)
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