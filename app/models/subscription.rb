class Subscription < ApplicationRecord
	belongs_to :user
	validates :chargify_id, presence: true
	validates :user_id, presence: true
	validates :state, presence: true

	def cancel_local_subscription 
		update_attributes(state: "canceled")
	end

	
end
