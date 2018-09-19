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
		assert_select "a[href=?]", update_payment_subscription_path
		assert_select "a[href=?]", change_plan_subscription_path
	end
end
