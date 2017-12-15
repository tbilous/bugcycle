module Filterable
  extend ActiveSupport::Concern

  included do
    def self.filter?(item_id, user_id)
      where(item_id: item_id, user_id: user_id).present?
    end

    def self.add_to_blacklist(item_id, user_id)
      item = Item.find(item_id)
      user = User.find(user_id)
      error = nil
      filter = nil

      if BlackList.filter?(item_id, user_id) || user.owner_of?(item)
        error = 'forbidden!'
      else
        filter = create!(item_id: item_id, user_id: user_id)
      end
      send_response(error, filter)
    end

    def self.send_response(error, object)
      error ? [false, error] : [true, object]
    end
  end
end
