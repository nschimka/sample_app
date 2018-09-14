class Subscription < ApplicationRecord
	belongs_to :user
	validates :chargify_id, presence: true
	validates :user_id, presence: true
	#attr_accessor :chargify_id
end
