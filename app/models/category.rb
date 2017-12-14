class Category < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy

  validates_presence_of :title
  validates :title, uniqueness: { case_sensitive: false }

  def self.options_for_select
    all.map do |category|
      [category.title, category.id]
    end
  end
end
