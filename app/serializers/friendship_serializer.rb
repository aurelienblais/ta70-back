# frozen_string_literal: true

class FriendshipSerializer
  include FastJsonapi::ObjectSerializer

  attributes :friend do |friendship, params|
    if params[:current_user] == friendship.user
      {
        name: friendship.user.name
      }
    else
      {
        name: friendship.friend.name
      }
    end
  end
end
