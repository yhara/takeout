require 'test_helper'

class CommitsControllerTest < ActionController::TestCase
  setup do
    @commit = commits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:commits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create commit" do
    assert_difference('Commit.count') do
      post :create, commit: { commited_at: @commit.commited_at, diff: @commit.diff, key: @commit.key, log: @commit.log, status: @commit.status }
    end

    assert_redirected_to commit_path(assigns(:commit))
  end

  test "should show commit" do
    get :show, id: @commit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @commit
    assert_response :success
  end

  test "should update commit" do
    put :update, id: @commit, commit: { commited_at: @commit.commited_at, diff: @commit.diff, key: @commit.key, log: @commit.log, status: @commit.status }
    assert_redirected_to commit_path(assigns(:commit))
  end

  test "should destroy commit" do
    assert_difference('Commit.count', -1) do
      delete :destroy, id: @commit
    end

    assert_redirected_to commits_path
  end
end
