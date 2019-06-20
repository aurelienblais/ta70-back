# frozen_string_literal: true

class FriendshipsController < ApplicationController
  api :GET, '/friendships'
  returns code: 200, desc: 'List all friends' do
    property :id, :number, desc: 'Crawl id'
    property :attributes, Hash do
      property :friend, Hash do
        property :name, String
      end
    end
  end
  returns code: [400, 401], desc: 'Raised if a params is missing' do
    property :errors, Hash, desc: 'Error details' do
      property :status, String, desc: 'Error code'
      property :title, String, desc: 'Error title'
      property :detail, Hash, desc: 'Error per field'
    end
  end

  def index
    render json: FriendshipSerializer.new(Friendship.friend_for(current_user), params: { current_user: current_user }).serialized_json
  end

  api :GET, '/friendships/waiting'
  returns code: 200, desc: 'List all pending requests' do
    property :id, :number, desc: 'Crawl id'
    property :attributes, Hash do
      property :friend, Hash do
        property :name, String
      end
    end
  end
  returns code: [400, 401], desc: 'Raised if a params is missing' do
    property :errors, Hash, desc: 'Error details' do
      property :status, String, desc: 'Error code'
      property :title, String, desc: 'Error title'
      property :detail, Hash, desc: 'Error per field'
    end
  end

  def waiting
    render json: FriendshipSerializer.new(Friendship.waiting_for(current_user), params: { current_user: current_user }).serialized_json
  end

  api :POST, '/friendships'
  param :friendship, Hash do
    param :email, String
  end
  returns code: 200, desc: 'Return a crawls' do
    property :id, :number, desc: 'Crawl id'
    property :attributes, Hash do
      property :friend, Hash do
        property :name, String
      end
    end
  end
  returns code: [401, 404], desc: 'Raised if a params is missing' do
    property :errors, Hash, desc: 'Error details' do
      property :status, String, desc: 'Error code'
      property :title, String, desc: 'Error title'
      property :detail, Hash, desc: 'Error per field'
    end
  end

  def create
    @friendship = Friendship.create!(user_id: current_user.id, friend: User.find_by_email!(friendship_params[:email]))
    render json: FriendshipSerializer.new(@friendship).serialized_json
  end

  api :PATCH, '/friendships/:id'
  param :friendship, Hash do
    param :accepted, [true, false]
  end
  returns code: 200, desc: 'Return a crawls' do
    property :id, :number, desc: 'Crawl id'
    property :attributes, Hash do
      property :friend, Hash do
        property :name, String
      end
    end
  end
  returns code: [400, 401], desc: 'Raised if a params is missing' do
    property :errors, Hash, desc: 'Error details' do
      property :status, String, desc: 'Error code'
      property :title, String, desc: 'Error title'
      property :detail, Hash, desc: 'Error per field'
    end
  end

  def update
    @friendship = Friendship.find params[:id]
    authorize @friendship
    @friendship.update! friendship_params
    render json: FriendshipSerializer.new(@friendship).serialized_json
  end

  api :DELETE, '/friendships/:id'
  returns code: 200
  returns code: [400, 401], desc: 'Raised if a params is missing' do
    property :errors, Hash, desc: 'Error details' do
      property :status, String, desc: 'Error code'
      property :title, String, desc: 'Error title'
      property :detail, Hash, desc: 'Error per field'
    end
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
