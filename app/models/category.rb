class Category < ApplicationRecord
  belongs_to :user
  has_many :items

  validates_presence_of :title
end
