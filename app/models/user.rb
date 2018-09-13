class User < ApplicationRecord
	has_many :microposts, dependent: :destroy
	has_many :subscriptions, dependent: :destroy
	has_many :active_relationships, class_name: "Relationship",
							foreign_key: "follower_id",
							dependent: :destroy
	has_many :following, through: :active_relationships, source: :followed
	has_many :passive_relationships, class_name: "Relationship",
							foreign_key: "followed_id",
							dependent: :destroy
	#source unneeded below because Rails knows to singularize follower
	has_many :followers, through: :passive_relationships, source: :follower

	before_save :downcase_email
	before_create :create_activation_digest
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates(:email, presence: true, length: { maximum: 255 }, 
		format: { with: VALID_EMAIL_REGEX }, 
		uniqueness: { case_sensitive: false})

	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

	attr_accessor :remember_token, :activation_token, :reset_token

	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	def forget
		update_attribute(:remember_digest, nil)
	end

	#Returns true if the given token matches the digest
	def authenticated?(attribute, token)
		digest = send("#{attribute}_digest")
		return false if digest.nil?
		BCrypt::Password.new(digest) .is_password?(token)
	end

	#Returns hash digest of a given string
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
													  BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	def User.new_token
		SecureRandom.urlsafe_base64
	end

	def activate
		update_columns(activated: true, activated_at: Time.zone.now)
	end

	def send_activation_email
		UserMailer.account_activation(self).deliver_now
	end

	def create_reset_digest
		self.reset_token = User.new_token
		update_attributes(reset_digest: User.digest(reset_token),
						reset_sent_at: Time.zone.now)
		#update_attribute(:reset_digest, User.digest(reset_token))
		#update_attribute(:reset_sent_at, Time.zone.now)
	end

	def send_password_reset_email
		UserMailer.password_reset(self).deliver_now
	end

	def password_reset_expired?
		reset_sent_at < 2.hours.ago # < is earlier than, not less than
	end

	#Defines a proto-feed of microposts on home page
	def feed
		#question mark ensures id val is escaped before being included in the SQL
		#query to protect from SQL injections
		#Micropost.where("user_id IN", id) only includes user's posts

		#following_ids is provided by Active Record by default
		#is same as User.first.following.map(&:id)
		#which is calling the id method on every member of array
		#following_ids is interpolated with (?)
		#BUT this method is slow
		#Micropost.where("user_id IN (?) OR user_id = ?", following_ids, id)
	
		#this uses a subselect, which arranges for the set logic to be 
		#done in the DB (more efficient)
		following_ids = "SELECT followed_id FROM relationships
						WHERE follower_id = :user_id"
		Micropost.where("user_id IN (#{following_ids}) OR user_id = :user_id",
					user_id: id)
	end

	#follow another user
	def follow(other_user)
		following << other_user
	end

	#stop following a user
	def unfollow(other_user)
		following.delete(other_user)
	end

	#return true if curr user is following other user
	def following?(other_user)
		following.include?(other_user)
	end

	private

		def downcase_email
			#self.email = email.downcase
			email.downcase!
		end

		def create_activation_digest
			self.activation_token = User.new_token
			self.activation_digest = User.digest(activation_token)
		end
end