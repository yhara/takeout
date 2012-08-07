require 'test_helper'

class NotesControllerTest < ActionController::TestCase
  setup do
    @commit = commits(:one)
  end

  test "should create note" do
    assert_difference('Note.count') do
      post :create, commit_id: @commit.id, note: { body: "hello" }
    end

    assert_redirected_to @commit
  end
end
