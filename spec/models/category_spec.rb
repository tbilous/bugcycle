require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:items) }
  it { should validate_presence_of :title }
  it { should validate_uniqueness_of(:title).case_insensitive }
end
