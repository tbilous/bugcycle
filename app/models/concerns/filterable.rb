module Filterable
  extend ActiveSupport::Concern

  included do
    def had_filtered?(item_id, user_id)
      item_id == self.item_id && user_id == self.user_id
    end

    def not_filtered?(item_id, user_id)
      item_id != self.item_id && user_id != self.user_id
    end

    def self.filter?(item_id, user_id)
      where(item_id: item_id, user_id: user_id).present?
    end

    def self.add_to_blacklist(item_id, user_id)
      item = Item.find(item_id)
      user = User.find(user_id)
      error = nil

      if BlackList.filter?(item_id, user_id) || user.owner_of?(item)
        error = 'forbidden!'
      else
        create(item_id: item_id, user_id: user_id)
      end
      send_response(error)
    end

    def self.send_response(error)
      error ? [false, error] : [true, '']
    end
  end
end
