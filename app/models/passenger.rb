class Passenger < ApplicationRecord
  has_and_belongs_to_many :flights

  def self.adults_only
    where("age > 18")
  end
end
