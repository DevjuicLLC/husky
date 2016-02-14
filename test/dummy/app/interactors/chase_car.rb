class ChaseCar < Husky::Interactor

  attr_accessor :car

  def initialize(car = "Honda")
    @car = car
  end

  def run
    broadcast(:chase_succeeded_for, car)
  end

end