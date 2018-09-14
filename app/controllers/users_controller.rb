class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                    :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user,  only: :destroy

  include ChargifyHelper

  def new
  	@user = User.new
  end

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      full_name = @user.name.split()
      first_name = full_name[0]
      last_name = full_name[1]
      
      configure_chargify
      sub = Chargify::Subscription.create(
        product_handle: "trial",
        customer_attributes: {
          first_name: first_name,
          last_name: last_name,
          email: @user.email
        }
      )
      if sub.errors.any?
        #puts sub.errors.messages
        render :json => { :errors => sub.errors.full_messages }
        flash[:danger] = "We could not create an account for you."
      else
        @subscription = @user.subscriptions.build(chargify_id: sub.id)
        @subscription.save
        @user.send_activation_email
        flash[:success] = "Your free trial has begun! Please check your email to activate your account."
        redirect_to root_url
      end
      
  	else
  		render 'new'
  	end
  end

  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    redirect_to root_url and return unless @user.activated?
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  
#this stuff ain't workin

  #page to ask for another activation email
  #get
  def new_activation
  end

  #this is for re-sending an activation email
  #post
  def resend_activation
    @user = User.find_by(email: params[:q])

    if !@user 
      flash[:danger] = "No account was found with that e-mail address."
      redirect_to signup_path
    elsif !@user.activated?
      @user.send_activation_email
      flash[:success] = "Please check your email to activate your account."
      redirect_to root_url
    elsif @user.activated?
      flash[:info] = "Your account has already been activated."
      redirect_to login_path
    end
    
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
  	def user_params
  		params.require(:user).permit(:name, :email, :password, 
  			:password_confirmation)
  	end

    #Before filters

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
