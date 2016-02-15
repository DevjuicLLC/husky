require 'test_helper'

class PassAlongTest < ActiveSupport::TestCase

  # After a method is called on a Responder, we need to send all instance variables
  # that were created back to the controller for the view
  test 'the receiver receives all instance variables from the sender after a method is called' do
    sam = Sam.new("Sam", "M", "Opportunist")
    bob = Bob.new
    PassAlong.all_variables(sam, bob)
    sam.useless_method
    assert_equal [:@gender, :@job_title, :@name], bob.instance_variables.sort
  end


  class Sam
    extend AfterDo

    def initialize(name, gender, job_title)
      @name      = name
      @gender    = gender
      @job_title = job_title
    end

    def useless_method
    end

  end

  class Bob
  end

end