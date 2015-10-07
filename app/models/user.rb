class User < ActiveRecord::Base
	before_save { email.downcase! }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i  # case insensitive
	validates(:email, presence: true, format:{ with: VALID_EMAIL_REGEX }, 
		uniqueness:{ case_sensitive:false })
end
