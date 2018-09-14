require 'test_helper'

class SubscriptionUpdateTest < ActionDispatch::IntegrationTest
	include ApplicationHelper

	def setup
		@user = users(:barbara)
		@subscription = subscriptions(:one)
	end


end
