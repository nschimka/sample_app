require 'test_helper'

class SubscriptionShowTest < ActionDispatch::IntegrationTest
	include ApplicationHelper

	def setup
		@user = users(:barbara)
		@subscription = subscriptions(:one)
	end

	test "profile display" do 
		log_in_as @user
		get subscription_path(@user)
		assert_template 'subscriptions/show'
		assert_select 'title', full_title("Your Subscription")
		assert_select 'h1', text: "Your Subscription"
		assert_select "a[href=?]", cancel_subscription_path
		assert_select "a[href=?]", "Update my card"
		assert_select "a[href=?]", "Put my subscription on hold"
		assert_select "a[href=?]", "Change my plan"
	end
end
