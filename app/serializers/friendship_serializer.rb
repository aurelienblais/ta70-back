# frozen_string_literal: true

class FriendshipSerializer
  include FastJsonapi::ObjectSerializer

  attributes :friend do |friendship, params|
    if params[:current_user] == friendship.user
      {
        id: friendship.friend.id,
        name: friendship.friend.name
      }
    else
      {
        id: friendship.user.id,
        name: friendship.user.name
      }
    end
  end
end
