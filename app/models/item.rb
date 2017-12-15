class Item < ApplicationRecord
  include Pictureable
  # has_attached_file :picture,
  #                   default_url: '/images/:style/no_picture.png',
  #                   styles: { medium: '300x200#',
  #                             thumb: '100x100#' }

  belongs_to :category
  belongs_to :user
  has_many :black_lists, dependent: :destroy
  has_many :suggestions, dependent: :destroy

  validates_presence_of :title, :description, :picture
  validates :title, uniqueness: { case_sensitive: false }
  # validates_attachment :picture,
  #                      content_type: { content_type: %w(image/jpg image/jpeg image/png image/gif) }

  scope :searchable, -> { where.not(id: BlackList.pluck(:item_id)) }
  scope :things_of_other, ->(user_id) { where.not(user_id: user_id) }
  scope :with_category, ->(category_id) { where(category_id: category_id) }

  def self.text_search(query)
    where(['LOWER(title) ilike :query',
           'LOWER(description) ilike :query'].join(' OR '), query: "%#{query}%")
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
