class HomeController < ApplicationController

  def index
    chase = ChaseCar.new(params[:car])
    listen_to chase
    chase.run
  end

end