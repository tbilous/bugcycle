class BlackList < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates_presence_of :user_id, :item_id
  validates :user_id, uniqueness: { scope: :item_id }
end
