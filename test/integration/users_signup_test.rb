require 'test_helper'

include ChargifyHelper

class UsersSignupTest < ActionDispatch::IntegrationTest
  
	def setup
		ActionMailer::Base.deliveries.clear
	end

  	test "invalid signup information" do
		get signup_path
		assert_select 'form[action="/users"]'
		
		assert_no_difference 'User.count' do 
			post users_path, params: { user: { name: "", email: "invalid",
										password: "foo", password_confirmation: "bar"} }
			
		end
		assert_template 'users/new'
		assert_select 'div#error_explanation'
		assert_select 'div.alert-danger'

	end

	test "valid signup information with account activation....." do
		get signup_path

		assert_difference 'User.count', 1 do
			post users_path, params: { user: { name: "Example Person", email: "ex@example.com",
								password: "password", password_confirmation: "password"}}
		end

		assert_equal 1, ActionMailer::Base.deliveries.size
		user = assigns(:user)
		assert_not user.activated?

		#verify chargify subscription created
		configure_chargify
		chargify = user.subscriptions.first.chargify_id
		#will error with 404 if unsuccessful
		Chargify::Subscription.find(chargify) 

		#Logging in before activation should fail
		log_in_as(user)
		assert_not is_logged_in?

		#invalid activation token
		get edit_account_activation_path("invalid token", email: user.email)
		assert_not is_logged_in?

		#valid activation token, wrong email
		get edit_account_activation_path(user.activation_token, email: 'no')
		assert_not is_logged_in?

		#valid activation token
		get edit_account_activation_path(user.activation_token, email: user.email)
		assert user.reload.activated?
		follow_redirect!
		
		assert_template 'users/show'
		assert_select 'div.alert-success'
		assert_not flash.nil?
	end

end
