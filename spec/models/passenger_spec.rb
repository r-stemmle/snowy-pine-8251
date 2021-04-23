require 'rails_helper'

RSpec.describe Passenger, type: :model do
  it {should have_and_belong_to_many :flights}
end
