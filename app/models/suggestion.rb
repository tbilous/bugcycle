class Suggestion < ApplicationRecord
  include Pictureable

  belongs_to :user
  belongs_to :item
  belongs_to :category
  # belongs_to :author, foreign_key: :author_id, class_name: User

  validates_presence_of :title, :description, :category_id
  validates :user_id, uniqueness: { scope: :item_id }

  def self.permitted?(args)
    where(item_id: args[:item_id], user_id: args[:user_id]).present?
  end

  def self.add_suggestion(args)
    item = Item.find(args[:item_id])
    error = nil
    suggestion = nil

    if Suggestion.permitted?(item_id: item.id, user_id: args[:user_id]) || item.user_id == args[:user_id]
      error = I18n.t('activerecord.errors.models.suggestion.add_suggestion')
    else
      suggestion = create!(item_id: args[:item_id],
                           user_id: args[:user_id],
                           category_id: item.category_id,
                           author_id: item.user_id,
                           title: item.title,
                           description: item.description,
                           item_picture: item.picture.url(:original))
    end
    send_response(error, suggestion)
  end

  def self.send_response(error, object)
    error ? [false, error] : [true, object]
  end
end
