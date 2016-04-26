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

  end

end

Husky::Responder.after :initialize do |*, responder|
  PassAlong.all_variables(responder, responder.context)
end