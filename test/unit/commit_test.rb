require 'test_helper'

class CommitTest < ActiveSupport::TestCase
  test "should set default status" do
    c = Commit.create!(key: "r1")
    assert_equal Takeout::Conf[:status_default], c.status
  end

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
