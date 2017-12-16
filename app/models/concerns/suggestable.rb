module Suggestable
  extend ActiveSupport::Concern

  included do
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

    def apply
      @item = Item.find(item_id)
      @item.update(
        title: title,
        description: description,
        category_id: category_id
      )

      if picture.present?
        @item.picture = picture
        @item.save
      end
      destroy!

      Suggestion.send_response(nil, @item)
    end
  end
end
