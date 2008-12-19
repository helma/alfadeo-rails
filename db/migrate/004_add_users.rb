class AddUsers < ActiveRecord::Migration
  def self.up
		User.create :name => 'ch', :hashed_password => '1676411b3fedcad6393f762cff4cbb03'
		User.create :name => 'alfadeo', :hashed_password => '19073d04c93b6cbc6f542046232cdd8b'
  end

  def self.down
  end
end
