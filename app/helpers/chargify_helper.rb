module ChargifyHelper

	def configure_chargify
		Chargify.configure do |c|
		    c.api_key   = ENV['CHGFY_API_KEY']
		    c.subdomain = ENV['CHGFY_SUBDOMAIN']
		end
	end
end