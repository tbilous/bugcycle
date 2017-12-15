class Suggestion < ApplicationRecord
  include Pictureable
  include Suggestable

  belongs_to :user
  belongs_to :item
  belongs_to :category

  validates_presence_of :title, :description, :category_id
  validates :user_id, uniqueness: { scope: :item_id }
end
