require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:categories) }
  it { should have_many(:items) }
  it { should have_many(:black_lists) }
end
