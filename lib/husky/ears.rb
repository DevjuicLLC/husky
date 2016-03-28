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

    def deliver_entities(entities)
      render json: entities.map(&:object)
    end

    def deliver_entity(entity)
      render json: entity.object
    end

  end
end