class Item < ApplicationRecord

  has_attached_file :picture,
                    default_url: '/images/:style/no_picture.png',
                    styles: { medium: '300x200#',
                              thumb: '100x100#' }

  belongs_to :category
  belongs_to :user

  validates_presence_of :title, :description
  validates :title, uniqueness: { case_sensitive: false }
  validates_attachment :picture,
                       content_type: { content_type: %w(image/jpg image/jpeg image/png image/gif) }
end
