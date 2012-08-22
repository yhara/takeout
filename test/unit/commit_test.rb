require 'test_helper'

class CommitTest < ActiveSupport::TestCase
  test ".create should set default status" do
    c = Commit.create!(key: "r1")
    assert_equal Takeout::Conf[:status_default], c.status
  end

  test "#update_status! updates status from given note body" do
    c = Commit.create!(key: "r1")

    c.update_status!("#reviewed\nbar\nbaz")
    assert_equal "reviewed", c.status
    c.update_status!("@taro\nbar\nbaz")
    assert_equal "@taro", c.status
    c.update_status!("@taro foo\nbar\nbaz")
    assert_equal "@taro", c.status
  end

  test ".recent_commented returns recently updated commit first" do
    Commit.destroy_all
    c1 = Commit.create!(key: "r1")
    c2 = Commit.create!(key: "r2")
    c3 = Commit.create!(key: "r3")
    n = Note.new; n.commit = c2; n.save!
    n = Note.new; n.commit = c3; n.save!
    n = Note.new; n.commit = c2; n.save!

    assert_equal %w(r2 r3 r1), Commit.recent_commented.map(&:key)
  end
end
