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

  end
end