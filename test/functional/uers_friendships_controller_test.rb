require 'test_helper'

class UersFriendshipsControllerTest < ActionController::TestCase |
  context "#new" do
    context "when not logged in " do 
      should "redirect to the login page" do 
        get :new
        assert_response :redirect
      end
    end  

    context "when logged in" do
      setup do
        sign_in users (:Garan)
      end

      should "get new and return success" do
        get :new
        assert_response :success
      end

      should "should set a flash error if the friend_id params is missing" do
        get :new, {}
        assert_equal "Firend required", flash[:error]
      end

      should "display the friend's name" do
        get :new, friend_id: users(:jim)
        assert_match /#{users(:jim).full_name}/,response.body    
      end

      should "assign a new user friendship" do 
        get :new, friend_id: users(:jim)
        assert assigns(:user_friendships)
      end

      should "assign a new user friendship to the correct friend" do 
        get :new, friend_id: users(:jim)
        assert_equals users(:jim), assigns(:user_friendships).friend
      end

      should "assign a new user friendship to the current logged in user" do 
        get :new, friend_id: users(:jim)
        assert_equals users(:Garan), assigns(:user_friendships).user
      end

      should "return a 404 status if no friend is not found" do 
        get :new, friend_id: 'invalid'
        assert_response :not_found
      end

      should "ask if you really want to friend the user" do 
        get :new, friend_id: users(:jim)
        assert_match /Do you really want to friend #{users(:jim).full_name}?/, response.body
      end
    end
  end

  context "#create" do 
    context "when not logged in" do 
      should "redirect to the login page" do 
        get :new
        assert_response :redirect
        assert_redirected_to login_path
      end
    end

    context "when logged in" do 
      setup do
        sign_in usersr(:Garan)
      end

      context "with no friend_id"
        setup do 
          post :create
        end

        should "set the flash error message" do 
          assert !flash[:error].empty?
        end

        should "redirect to the site root" do 
          assert_redirected_to root_path
      end
    end

    context "with a valid friend_id" do 
      setup do
        post :create, friend_id: users(:mike)
      end

      should "assign a firend object" do 
        assert assigns(:friend)
      end

      should "assign a user_friendship object" do 
        assert assigns(:user_friendship)
        assert_equal users(:Garan), assigns(:user_friendship).user
        assert_equal users(:mike), assigns(:user_friendship).friend
      end
    end
  end
end
























