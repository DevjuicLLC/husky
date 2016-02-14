require 'delegate'
require 'after_do'

module Husky

  class Responder < SimpleDelegator
    extend AfterDo

    attr_reader :context

    def initialize(context)
      @context = context
      super
    end

    def successfully_created(object)
      raise NotImplementedError
    end

    def failed_to_create(object)
      raise NotImplementedError
    end

    def successfully_updated(object)
      raise NotImplementedError
    end

    def failed_to_update(object)
      raise NotImplementedError
    end

    def successfully_destroyed(object)
      raise NotImplementedError
    end

    def failed_to_destroy(object)
      raise NotImplementedError
    end

  end


end

Husky::Responder.after :initialize do |*, obj|
  obj.class.instance_methods(false).each do |method|
    obj.class.after method do |*, obj|
      pass_alongs = obj.instance_variables.dup
      pass_alongs.delete(:@context)
      pass_alongs.delete(:@delegate_sd_obj)
      pass_alongs.each do |var|
        obj.context.instance_variable_set(var, obj.instance_variable_get(var))
      end
    end
  end
end
