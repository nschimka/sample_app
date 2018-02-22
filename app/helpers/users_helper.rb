module UsersHelper
	def gravatar_for(user)
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    	gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}.png?s=64"
    	image_tag(gravatar_url, alt: user.name, class: "gravatar")
	end

end
