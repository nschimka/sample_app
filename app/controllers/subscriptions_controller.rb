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

	def update
		@user = User.find(params[:id])
		@subscription = @user.subscriptions.first
		sub_id = @subscription.chargify_id
		configure_chargify
		sub = Chargify::Subscription.find(sub_id)
		if params[:commit] == 'Cancel now'
			sub.cancel
			log_out
		elsif params[:commit] == 'Cancel later'
			sub.delayed_cancel
			flash.now[:success] = "Your subscription will cancel soon."
			render 'show'
		end
	end

end
