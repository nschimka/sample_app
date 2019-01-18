require 'test_helper'

class WebhooksControllerTest < ActionDispatch::IntegrationTest

	test "doesn't error when unexpected payloads are sent" do
		post chargify_webhooks_path, params: { id: 123456, event: "testing", payload: { chargify: "testing"}}
		assert_response(:success)

	end

end
