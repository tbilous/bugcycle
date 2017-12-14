class SearchesController < ApplicationController
  respond_to :json

  def search
    # binding.pry
    @items = Item.includes(:category).things_of_other(current_user).search(params)
    respond_with @items, each_serializer: ItemSearchSerializer
  end
end
