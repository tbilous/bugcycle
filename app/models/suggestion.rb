class Suggestion < ApplicationRecord
  include Pictureable

  belongs_to :user
  belongs_to :item
  belongs_to :category
  belongs_to :author, foreign_key: :author_id, class_name: User

  validates_presence_of :title, :description, :category_id
  validates :user_id, uniqueness: { scope: :item_id }
end
