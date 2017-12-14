require 'rails_helper'

RSpec.describe BlackList, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:item) }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :item_id }
  it do
    subject.user = build(:user)
    should validate_uniqueness_of(:user_id).scoped_to(:item_id)
  end
end
