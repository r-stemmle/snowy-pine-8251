require 'rails_helper'

RSpec.describe Passenger, type: :model do
  it {should have_and_belong_to_many :flights}

  describe "class methods" do
    describe ".adults_only" do
      it "only returns passengers older than 18" do
        p1 = Passenger.create!(name: "Joe", age: "3")
        p2 = Passenger.create!(name: "Jon", age: "13")
        p3 = Passenger.create!(name: "Joseph", age: "23")

        expect(Passenger.adults_only).to eq([p3])
      end

    end
  end
end
