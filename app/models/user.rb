require 'digest/md5'
class User < ActiveRecord::Base

	def validate
		errors.add_to_base('Missing password') if hashed_password.blank?
	end

	def self.authenticate(name, password)
		user = self.find_by_name(name)
		if user
			if user.hashed_password != Digest::MD5.hexdigest(password)
				user = nil
			end
		end
		user
	end

end
