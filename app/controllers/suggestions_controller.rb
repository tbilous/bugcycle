class SuggestionsController < ApplicationController
  before_action :load_item, only: %i(create)
  before_action :load_suggestion, only: %i(destroy update edit)

  load_and_authorize_resource

  def create
    success, error = suggestion = Suggestion.add_suggestion(
      item_id: @item.id,
      user_id: current_user.id
    )

    if success
      @suggestion = suggestion[1]
      respond_with @suggestion, location: edit_suggestion_path(@suggestion.id)
    elsif error
      redirect_to item_path(@item.id), alert: error
    end
  end

  def update
    @suggestion.update(strong_params)
    respond_with @suggestion
  end

  def destroy
    @item = Item.find(@suggestion.item_id)
    respond_with @suggestion.destroy, location: item_path(@item.id)
  end

  def edit
    respond_with @suggestion
  end

  def apply
    @suggestion = Suggestion.find(params[:suggestion_id])
    @item = Item.find(@suggestion.item_id)

    if @item.user_id == current_user.id
      respond_with @suggestion.apply, location: item_path(@item.id)
    else
      redirect_to root_path
    end
  end

  private

  def load_item
    @item = Item.find(params[:item_id])
  end

  def load_suggestion
    @suggestion = Suggestion.find(params[:id])
  end

  def strong_params
    params.require(:suggestion).permit(:title, :description, :user_id, :author_id, :picture, :item_picture,
                                       :category_id)
  end
end
