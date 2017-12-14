class BlackList < ApplicationRecord
  include Filterable

  belongs_to :user
  belongs_to :item

  validates_presence_of :user_id, :item_id
  validates :user_id, uniqueness: { scope: :item_id }

  # def had_filtered?(item_id, user_id)
  #   item_id == self.item_id && user_id == self.user_id
  # end
  #
  # def not_filtered?(item_id, user_id)
  #   item_id != self.item_id && user_id != self.user_id
  # end
  #
  # def self.filter?(item_id, user_id)
  #   where(item_id: item_id, user_id: user_id).present?
  # end
  #
  # def add_filter(item_id, user_id)
  #   if BlackList.filter?(item_id, user_id)
  #     false
  #   else
  #     create(item_id: item_id, user_id: user_id)
  #   end
  # end
end
