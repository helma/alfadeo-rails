class Release < ActiveRecord::Base
  has_many :tracks
  file_column :image
end
