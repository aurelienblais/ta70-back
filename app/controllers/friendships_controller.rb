# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def index
    render json: FriendshipSerializer.new(Friendship.friend_for(current_user), params: { current_user: current_user }).serialized_json
  end

  def waiting
    render json: FriendshipSerializer.new(Friendship.waiting_for(current_user), params: { current_user: current_user }).serialized_json
  end

  def create
    @friendship = Friendship.create!(user_id: current_user.id, friend: User.find_by_email!(friendship_params[:email]))
    render json: FriendshipSerializer.new(@friendship).serialized_json
  end

  def update
    @friendship = Friendship.find params[:id]
    authorize @friendship
    @friendship.update! friendship_params
    render json: FriendshipSerializer.new(@friendship).serialized_json
  end

  def destroy
    @friendship = Friendship.find params[:id]
    authorize @friendship
    @friendship.destroy!
    head :ok
  end

  private

  def friendship_params
    params.require(:friendship).permit(
      :email,
      :accepted
    )
  end
end
