require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  
	def setup
		@user = users(:barbara)
		@subscription = subscriptions(:one)
	end

	test "should be valid" do 
		assert @subscription.valid?
	end

	test "should require a Chargify subscription id" do
		@subscription.chargify_id = nil
		assert_not @subscription.valid?
	end

	test "should require an associated user" do
		@subscription.user_id = nil
		assert_not @subscription.valid?
	end

end
