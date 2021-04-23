require 'rails_helper'

RSpec.describe "Airlines Show Page" do
  describe "When I visit an airlines show page" do
    it "I see a list of passengers that have flights on that airline" do
      airline = Airline.create!(name: "TWA")
      flight = airline.flights.create!(number: 123, date: '2021-05-12', departure_city: 'Denver', arrival_city: 'Reno')
      p1 = flight.passengers.create!(name: "Joe", age: "23")
      p2 = flight.passengers.create!(name: "Mary", age: "44")
      p3 = flight.passengers.create!(name: "John", age: "55")

      visit airline_path(airline)

      expect(page).to have_content(p1.name)
      expect(page).to have_content(p2.name)
      expect(page).to have_content(p3.name)
    end

    it "And I see that this list is unique" do
      airline = Airline.create!(name: "TWA")
      flight = airline.flights.create!(number: 123, date: '2021-05-12', departure_city: 'Denver', arrival_city: 'Reno')
      p1 = Passenger.create!(name: "Joe", age: "23")
      p2 = flight.passengers.create!(name: "Mary", age: "44")
      p3 = flight.passengers.create!(name: "John", age: "55")
      flight.passengers << p1
      flight.passengers << p1

      visit airline_path(airline)
      expect(page).to have_content(p1.name, count: 1)
      expect(page).to have_content(p2.name)
      expect(page).to have_content(p3.name)
    end

    it "And I see that this list only includes passengers over age 18" do
      airline = Airline.create!(name: "TWA")
      flight = airline.flights.create!(number: 123, date: '2021-05-12', departure_city: 'Denver', arrival_city: 'Reno')
      p1 = Passenger.create!(name: "Joe", age: "23")
      p2 = flight.passengers.create!(name: "Mary", age: "44")
      p3 = flight.passengers.create!(name: "John", age: "55")
      young_lad = flight.passengers.create!(name: "Young Boy", age: "15")
      flight.passengers << p1

      visit airline_path(airline)

      expect(page).to have_content(p1.name)
      expect(page).to have_content(p2.name)
      expect(page).to have_content(p3.name)
      expect(page).to_not have_content(young_lad.name)
    end
  end
end
