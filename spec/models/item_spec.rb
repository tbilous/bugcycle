require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to(:category) }
  it { should belong_to(:user) }
  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
  it { should validate_uniqueness_of(:title).case_insensitive }

  it do
    should validate_attachment_content_type(:picture).allowing('image/png', 'image/gif', 'image/jpg', 'image/jpeg')
  end
end
