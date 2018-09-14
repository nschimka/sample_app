require 'test_helper'

class UsersHelperTest < ActionView::TestCase

	def setup
		@user = users(:barbara)
		@other = users(:lana)
	end

	#doesn't work -- needs to be integration test?
	test "redirect away from pages you don't own" do
		log_in_as @user
		get cancel_subscription_path(@other)
		assert_redirected_to root_url
		assert_not flash.empty?
	end
end