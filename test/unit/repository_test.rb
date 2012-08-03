# coding: utf-8
require 'test_helper'
require 'repository'

class Repository
  class SvnReposTest < ActiveSupport::TestCase
    setup do
      @url = "http://example.jp/svn/trunk"
      @repos = SvnRepos.new(@url)
    end

    test "get_latest_rev" do
      mock_svn("svn info #{@url}", <<-EOD)
Path: trunk
URL: http://example.jp/svn/trunk
Repository Root: http://example.jp/svn
Repository UUID: 620d0430-8dae-8356-fdc8-6691e7c1e7e5
Revision: 4
Node Kind: directory
Last Changed Author: yutaka.hara@example.com
Last Changed Rev: 4
Last Changed Date: 2012-08-02 20:57:01 +0900 (木, 02  8 2012)

      EOD

      assert_equal 4, @repos.send(:get_latest_rev)
    end

    test "fetch_commit" do
      mock_svn("svn log -r 3 #{@url}", <<-EOD)
------------------------------------------------------------------------
r3 | yutaka.hara@example.com | 2012-07-21 22:51:31 +0900 (土, 21  7 2012) | 2 lines

foo

bar
------------------------------------------------------------------------
      EOD

      diff = <<-EOD
Index: hello
===================================================================
--- hello       (revision 2)
+++ hello       (revision 3)
@@ -0,0 +1,1 @@
+asdflkjakldsjf lzxl
      EOD
      mock_svn("svn diff -r 2:3 #{@url}", diff)

      commit = @repos.fetch_commit("r3")

      assert_equal "r3", commit.key
      assert_equal "foo\n\nbar", commit.log
      assert_equal diff, commit.diff
      assert_equal DateTime.parse("2012-07-21 22:51:31 +0900"), commit.commited_at
      assert_equal "yutaka.hara@example.com", commit.author
    end

    private
    def mock_svn(cmd, out)
      @repos.expects(:command).with(cmd).returns(out)
    end
  end
end
