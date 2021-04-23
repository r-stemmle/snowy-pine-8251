require 'rails_helper'

RSpec.describe "Flight Index Page" do
  describe "As a visitor when I visit the flights index page" do
    it "I see a list of all flight numbers, airline name" do
      southwest = Airline.create!(name: "Southwest")
      united = Airline.create!(name: "United")
      twa = Airline.create!(name: "TWA")
      f1 = southwest.flights.create!(number: 234, date: '2021-05-21', departure_city: 'Denver', arrival_city: 'Reno')
      f2 = southwest.flights.create!(number: 345, date: '2021-05-22', departure_city: 'Denver', arrival_city: 'Reno')
      f3 = southwest.flights.create!(number: 456, date: '2021-05-23', departure_city: 'Denver', arrival_city: 'Reno')
      f4 = united.flights.create!(number: 777, date: '2021-05-21', departure_city: 'Denver', arrival_city: 'Reno')
      f5 = united.flights.create!(number: 888, date: '2021-04-29', departure_city: 'Denver', arrival_city: 'Reno')
      f6 = twa.flights.create!(number: 999, date: '2021-05-11', departure_city: 'Denver', arrival_city: 'Reno')
      p1 = Passenger.create!(name: 'Ryan', age: 36)
      p2 = Passenger.create!(name: 'Joe', age: 16)
      p3 = Passenger.create!(name: 'Kon', age: 26)
      p4 = Passenger.create!(name: 'Kurt', age: 33)
      p5 = Passenger.create!(name: 'Larry', age: 55)
      p6 = Passenger.create!(name: 'Mary', age: 6)
      p7 = Passenger.create!(name: 'Sue', age: 3)
      f1.passengers << [p1, p2, p7]
      f2.passengers << p5

      visit flights_path
save_and_open_page
      expect(page).to have_content(f1.number)
      expect(page).to have_content(f1.airline.name)
      expect(page).to have_content(p1.name)
      expect(page).to have_content(f2.number)
      expect(page).to have_content(f2.airline.name)
      expect(page).to have_content(f3.number)
    end
  end

end
