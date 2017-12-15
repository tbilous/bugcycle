require 'rails_helper'

RSpec.describe Suggestion, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:item) }
  it { should belong_to(:author).with_foreign_key(:author_id).class_name('User') }
  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
  it do
    subject.user = build(:user)
    should validate_uniqueness_of(:user_id).scoped_to(:item_id)
  end

  it do
    should validate_attachment_content_type(:picture)
      .allowing('image/png', 'image/gif', 'image/jpg', 'image/jpeg')
  end
end