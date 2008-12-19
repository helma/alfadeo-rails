class Track < ActiveRecord::Base

  belongs_to :release
  file_column :file

end
