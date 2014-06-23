require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:user_friendships)

  test "a user should enter a first name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:first_name].empty?
  end

  test "a user should enter a last name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:last_name].empty?
  end

  test "a user should enter a profile name" do
    user = User.new
    assert !user.save
    assert !user.errors[:profile_name].empty?
  end

  test "a user should have a unique profile name" do
    user = User.new
    assert !user.save
    assert !user.errors[:profile_name].empty?
  end

  test "a user should have a profile name without spaces" do
    user = User.new(first_name: 'Garan', last_name: 'Guillory', email: 'garanguillory@gmail.com')
    user.password = user.password_confirmation = 'garantreebook'

    user.profile_name = "My Profile With Spaces"
    
    assert !user.save
    assert !user.errors[:profile_name].empty?
    assert !user.errors[:profile_name].include?("Must be formatted correctly.")
  end

  test " a user can have a correctly formatted profile name" do
    user = User.new(first_name: 'Garan', last_name: 'Guillory', email: 'garanguillory@gmail.com')
    user.password = user.password_confirmation = 'garantreebook'

    user.profile_name = 'garanguillory'
    assert user.valid?
  end

  test "that no error is raised when trying to access a friend list" do
    assert_nothing_raised do
      users(:Garan).friends
    end
  end

  test "that creating friendships on a user works" do
    users(:jason).friends << users(:mike)
    users(:jason).friends.reload
    assert users(:jason).friends.include?(users(:mike))
  end

  test "that calling to_param on a user returns the profile_name" do 
    assert_equal "garanguillory", users(:Garan).to_param
  end
end












