module UsersHelper

	def gravatar_for(user, options = { size: 80 })
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		size = options[:size]
    	gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
    	image_tag(gravatar_url, alt: user.name, class: "gravatar")
	end

	def redirect_private_pages(user)
		if user != current_user
			redirect_to root_url
			flash[:info] = "You do not have access to that page."
		end

	end

end
