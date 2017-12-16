module Responsable
  extend ActiveSupport::Concern

  included do
    def self.permitted?(args)
      where(item_id: args[:item_id], user_id: args[:user_id]).present?
    end

    def self.send_response(error, object)
      error ? [false, error] : [true, object]
    end
  end
end
