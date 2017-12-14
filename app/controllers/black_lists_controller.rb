class BlackListsController < ApplicationController
  load_and_authorize_resource

  respond_to :json

  def create
    success, error = @black_list = BlackList.add_to_blacklist(params[:item_id], current_user.id)
    if success
      render json: { filter: error }.to_json
    else
      render json: { error: error }.to_json, status: :unprocessable_entity
    end
  end

  def destroy
    @black_list = BlackList.find(params[:id])
    respond_with @black_list.destroy
  end

  private

  def strong_params
    params.require(:black_list).permit(:user_id, :item_id)
  end
end
