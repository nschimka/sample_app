class AccountActivationsController < ApplicationController

	def edit
		@user = User.find_by(email: params[:email])
		if @user && !@user.activated? && @user.authenticated?(:activation, params[:id])
			@user.activate
			log_in @user
			flash[:success] = "Account activated!"
			redirect_to @user
		else
			flash[:danger] = "Invalid activation link"
			redirect_to root_url
		end
	end

	#page to ask for another activation email
	def new
	end

	#this is for re-sending an activation email
	def create
		user = User.find_by(email: params[:account_activations][:email])
		if user && !user.activated?
			user.create_activation_token
			user.send_activation_email
			flash[:success] = "Please check your email to activate your account."
			redirect_to root_url
		elsif user && user.activated?
			flash[:info] = "Your account has already been activated."
			redirect_to login_path
		else
			flash[:danger] = "No account was found with that e-mail address."
  			render 'new'
  		end
  	end

end
