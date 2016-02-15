require 'test_helper'

class ControllerToResponderTest < ActionDispatch::IntegrationTest

  test 'it can pass a variable from the controller to the responder through the listener' do
    get root_path(car: "Mustang")
    assert_includes response.body, "Mustang", "Should include the passed in value in the response."
  end

end