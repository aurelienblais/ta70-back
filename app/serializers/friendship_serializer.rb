# frozen_string_literal: true

class FriendshipSerializer
  include FastJsonapi::ObjectSerializer

  attributes :friend do |friendship, params|
    if params[:current_user] == friendship.user
      {
        name: friendship.friend.name
      }
    else
      {
        name: friendship.user.name
      }
    end
  end
end
