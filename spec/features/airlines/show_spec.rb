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

    it "Then I see the list of adult passengers is sorted by number of flights each pass has taken" do
      airline = Airline.create!(name: "TWA")
      flight_1 = airline.flights.create!(number: 123, date: '2021-03-12', departure_city: 'Denver', arrival_city: 'Reno')
      flight_2 = airline.flights.create!(number: 321, date: '2021-02-12', departure_city: 'Denver', arrival_city: 'Reno')
      flight_3 = airline.flights.create!(number: 231, date: '2021-01-12', departure_city: 'Denver', arrival_city: 'Reno')
      p1 = Passenger.create!(name: "Joe", age: "23")
      p4 = Passenger.create!(name: "Steve", age: "46")
      p5 = Passenger.create!(name: "Candice", age: "45")
      p2 = flight_1.passengers.create!(name: "Mary", age: "44")
      p3 = flight_1.passengers.create!(name: "John", age: "55")
      young_lad = flight_1.passengers.create!(name: "Young Boy", age: "15")
      flight_1.passengers << [p1, p4]
      flight_2.passengers << [p1, p5]
      flight_3.passengers << [p1, p5]

      visit airline_path(airline)

      within ".passengers" do
        # expect(p1.name).to appear_before(p5.name)
        # expect(p5.name).to appear_before(p4.name)
      end
    end
  end
end
