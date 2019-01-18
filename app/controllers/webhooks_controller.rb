class Chargify::WebhooksController < ApplicationController

	include ChargifyHelper

	skip_before_action :verify_authenticity_token

	def create
		data = params.as_json
		if data['event'] == "renewal_success"
			sub_id = data['payload']['subscription']['id']
			configure_chargify
			sub = Chargify::Subscription.find(sub_id)
			new_billing = sub.next_assessment_at.strftime('%m/1/%Y %H:%M %p')
			sub.update_attributes(next_billing_at: new_billing)
		end
		render nothing: true, status: 201
	end

end