class HomeResponder < Husky::Responder

  def chase_succeeded_for(car)
    @car = car
  end

end