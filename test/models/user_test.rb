require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
  	@user = User.new(name: "Example User", email: "user@example.com", 
      password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid"  do 
  	assert @user.valid?
  end
  
  test "name should be present" do
  	@user.name = "	"
  	assert_not @user.valid?
  end

  test "email should be present" do
  	@user.email = "	"
  	assert_not @user.valid?
  end

  test "name should not be too long" do
  	@user.name = "a" * 51
  	assert_not @user.valid?
  end

  test "email should not be too long" do
  	@user.email = "a" * 244 + "@example.com"
  	assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
  	valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
  	valid_addresses.each do |addr|
  		@user.email = addr
  		assert @user.valid?, "#{addr.inspect} should be valid"
  	end
  end

  test "email validation should reject invalid addresses" do
  	invalid_addresses = %w[user@example,com user_at_foo.org bo@do..com user.name@example.foo@bar_baz.com foo@bar+baz.com]
  	invalid_addresses.each do |addr|
  		@user.email = addr
  		assert_not @user.valid?, "#{addr.inspect} should be invalid"
  	end
  end

  test "email addresses should be unique" do
  	duplicate_user = @user.dup
  	duplicate_user.email = @user.email.upcase
  	@user.save
  	assert_not duplicate_user.valid?
  end

  test "email address should be saved as lower-case" do
    mixed_case = "Foo@ExAMPle.CoM"
    @user.email = mixed_case
    @user.save
    assert_equal mixed_case.downcase, @user.reload.email
  end

  test "password should be nonblank" do
    @user.password = @user.password_confirmation = "         "
    assert_not @user.valid?
  end

  test "password should have minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference "Micropost.count", -1 do
      @user.destroy
    end
  end

  test "associated subscriptions should be destroyed" do
    @user.save
    @user.subscriptions.create!(chargify_id: 1111, state: "active")
    assert_difference "Subscription.count", -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
    barbara = users(:barbara)
    lana = users(:lana)
    assert_not lana.following?(barbara)
    lana.follow(barbara)
    assert lana.following?(barbara)
    assert barbara.followers.include?(lana)
    lana.unfollow(barbara)
    assert_not lana.following?(barbara)
  end

  test "feed should have the right posts" do
    #barbara follows lana but not andy
    barbara = users(:barbara)
    lana = users(:lana)
    andy = users(:andy)

    #Posts from followed user
    lana.microposts.each do |post_following|
      assert barbara.feed.include?(post_following)
    end

    #Posts from self
    barbara.microposts.each do |post_self|
      assert barbara.feed.include?(post_self)
    end

    #Posts from unfollowed user
    andy.microposts.each do |post_unfollowed|
      assert_not barbara.feed.include?(post_unfollowed)
    end
  end

end
