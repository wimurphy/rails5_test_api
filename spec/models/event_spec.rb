require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should have_many(:people).dependent(:destroy) }
  it { should validate_presence_of(:name) }
end
