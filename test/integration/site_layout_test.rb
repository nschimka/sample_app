require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  test "layout links" do
	get root_path
	assert_template 'static_pages/home'
	assert_select "a[href=?]", root_path, count: 2
	assert_select "a[href=?]", about_path
	assert_select "a[href=?]", login_path
	assert_select "a[href=?]", pricing_path
	get pricing_path
	assert_select "title", full_title("Pricing")
	
	user = users(:barbara)
	log_in_as(user)
	get root_path
	assert_select "a[href=?]", logout_path
	assert_select "a[href=?]", users_path
	assert_select "a[href=?]", user_path(user)
	assert_select "a[href=?]", edit_user_path(user)
	assert_select "a[href=?]", subscription_path(user)
	assert_select "a[href=?]", pricing_path, false

   end
end
