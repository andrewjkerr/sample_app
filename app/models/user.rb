class User < ActiveRecord::Base
	# Callback to force the email to lowercase to enforce uniqueness
	before_save { self.email = email.downcase }

	# Validates name is not empty and sets a max length of 50 chars
	validates :name, presence: true, length: { maximum: 50 }

	# Validates email is not empty, an actual email address, and that it is unique
	# Uniqueness is also defined in the database via a db migration
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

	# Following method does a lot of cool things with passwords as long as there is a password_digest column in the DB
	has_secure_password

	# Validates password is not empty and has a minimum length of 6 chars
	validates :password, presence: true, length: { minimum: 6 }
end
