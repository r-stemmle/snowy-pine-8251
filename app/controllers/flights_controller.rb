class FlightsController < ApplicationController
  def index
    @flights = Flight.all
  end

  def update
    flight = Flight.find(params[:flight_id])
    passenger = Passenger.find(params[:id])
    flight.passengers.delete(passenger)
    redirect_to flights_path
  end
end
