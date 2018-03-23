require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  	test "invalid signup information" do
		get signup_path
		assert_select 'form[action="/signup"]'
		
		assert_no_difference 'User.count' do 
			post users_path, params: { user: { name: "", email: "invalid",
										password: "foo", password_confirmation: "bar"} }
			
		end
		assert_template 'users/new'
		assert_select 'div#error_explanation'
		assert_select 'div.alert-danger'

	end

	test "valid signup information" do
		get signup_path

		assert_difference 'User.count', 1 do
			post users_path, params: { user: { name: "b", email: "e@example.com",
								password: "password", password_confirmation: "password"}}
		end

		assert is_logged_in?
		follow_redirect!
		assert_template 'users/show'
		assert_select 'div.alert-success'
		assert_not flash.nil?
	end

end
