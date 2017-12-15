module Pictureable
  extend ActiveSupport::Concern

  included do
    has_attached_file :picture,
                      default_url: '/images/:style/no_picture.png',
                      styles: { medium: '300x200#',
                                thumb: '100x100#' }

    validates_attachment :picture,
                         content_type: { content_type: %w(image/jpg image/jpeg image/png image/gif) }
  end
end
