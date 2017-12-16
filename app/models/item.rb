class Item < ApplicationRecord
  include Pictureable

  belongs_to :category
  belongs_to :user
  has_many :black_lists, dependent: :destroy
  has_many :suggestions, dependent: :destroy

  validates_presence_of :title, :description, :picture
  validates :title, uniqueness: { case_sensitive: false }

  scope :searchable, -> { where.not(id: BlackList.pluck(:item_id)) }
  scope :things_of_other, ->(user_id) { where.not(user_id: user_id) }
  scope :with_category, ->(category_id) { where(category_id: category_id) }

  def self.text_search(query)
    where(['title ilike :query',
           'description ilike :query'].join(' OR '), query: "%#{query}%")
  end

  def self.search(query)
    search_params = {
      category_id: :with_category,
      text: :text_search
    }

    result = where(nil)
    search_params.each do |k, v|
      result = result.send(v, query[k]) if query[k].present?
    end
    result
  end
end
