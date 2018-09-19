class SubscriptionsController < ApplicationController

include UsersHelper
include ChargifyHelper

	def show
		@user = User.find(params[:id])
		@subscription = @user.subscriptions.first
    	redirect_private_pages(@user)
	end

	def cancel
		@user = User.find(params[:id])
		@subscription = @user.subscriptions.first
		redirect_private_pages(@user)
	end

	def update_payment

	end

	def change_plan

	end

	def update
		@user = User.find(params[:id])
		@subscription = @user.subscriptions.first
		configure_chargify
		sub = Chargify::Subscription.find(@subscription.chargify_id)

		#This doesn't prevent users from logging in again 
		if params[:commit] == 'Cancel now'
			sub.cancel
			@subscription.cancel_local_subscription
			log_out
			redirect_to signup_path
			flash[:success] = "Your subscription has been canceled."

		elsif params[:commit] == 'Cancel later'
			sub.delayed_cancel
			flash.now[:success] = "Your subscription will cancel soon."
			render 'show'
		end
	end

end
