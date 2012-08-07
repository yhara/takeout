require 'test_helper'

class CommitTest < ActiveSupport::TestCase
  test "update_status! updates status from given note body" do
    c = Commit.create!(key: "r1")

    c.update_status!("#reviewed\nbar\nbaz")
    assert_equal "reviewed", c.status
    c.update_status!("@taro\nbar\nbaz")
    assert_equal "@taro", c.status
    c.update_status!("@taro foo\nbar\nbaz")
    assert_equal "@taro", c.status
  end
end
