require 'delegate'
require 'after_do'
require 'husky/pass_along'

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

Husky::Responder.after :initialize do |*, responder|
  PassAlong.all_variables(responder, responder.context)
end