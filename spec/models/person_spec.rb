require 'rails_helper'

RSpec.describe Person, type: :model do
  it { should belong_to(:event) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:company) }
end
