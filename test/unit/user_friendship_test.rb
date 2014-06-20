require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:friend)

  test "that creating a friendship works without raising an exception" do
    assert_nothing_raised do 
      UserFriendship.create user: users(:Garan), friend: users(:mike)
    end
  end


  test "that creating a friendship based on user id and friend id works" do
    UserFriendships.create user_id: users(:Garan), friend: users(:mike).id
    assert users(:Garan).friends.include?(users(:mike))
  end
end
