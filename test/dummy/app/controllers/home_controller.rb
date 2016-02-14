class HomeController < ApplicationController

  def index
    car = "Accord"
    chase = ChaseCar.new(car)
    listen_to chase
    chase.run
  end

end