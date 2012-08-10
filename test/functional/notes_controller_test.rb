require 'test_helper'

class NotesControllerTest < ActionController::TestCase
  setup do
    @commit = commits(:one)
  end

  test "should create note" do
    assert_difference('Note.count') do
      post :create, commit_id: @commit.id, note: { body: "hello" }
    end

    assert_redirected_to commits_path

    assert_equal "hello", Note.last.body
  end

  test "should create note with name" do
    assert_difference('Note.count') do
      post :create, commit_id: @commit.id, note: { body: "hello" }, name: "taro"
    end

    assert_redirected_to commits_path

    assert_equal "hello\n\n-- taro", Note.last.body
    assert_equal "taro", cookies[:author_name]
  end
end
