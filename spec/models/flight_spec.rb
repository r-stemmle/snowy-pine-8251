require 'rails_helper'

RSpec.describe Flight, type: :model do
  it {should belong_to :airline}
end
