module Husky

  module Broadcaster

    def add_listener(object)
      @listeners ||= []
      @listeners << object
    end

    def broadcast(message, *args)
      @listeners ||= []
      @listeners.each do |listener|
        listener.send(message, *args) if listener.respond_to?(message)
      end
    end

  end

end