require 'zip/zipfilesystem'

class Release < ActiveRecord::Base

  has_many :tracks
  file_column :image
  file_column :zip

  before_save :create_zip

  def create_zip
    if self.publish
      self.zip = nil if self.zip
      tmp_zip = "#{RAILS_ROOT}/tmp/alfadeo-#{name}.zip"
      FileUtils.rm(tmp_zip) if File.exist?(tmp_zip)
      Zip::ZipFile.open(tmp_zip, Zip::ZipFile::CREATE) do |zipfile|

        if self.image
          image_type = File.extname(self.image)
          zipfile.add("alfadeo-#{name}/#{name}.#{image-type}",self.image)
        end

        if self.sorted_tracks
          self.sorted_tracks.each do |t|
            zipfile.add("alfadeo-#{name}/#{t.name}.mp3",t.file)
          end
          zipfile.close
        end

      end
      self.zip = File.open(tmp_zip)
      #FileUtils.rm(tmp_zip) if File.exist?(tmp_zip)
    end
  end

  def sorted_tracks
    begin
      tracks.sort{|a,b| a.position <=> b.position}
    rescue
      tracks
    end
  end

  def size
    size = 0.0
    tracks.each do |t|
      size += File.size?(t.file).to_f/1024/1024
    end
    sprintf("%.2f", size)
  end

  def duration
    length = 0.0
    tracks.each do |t|
      length += File.size?(t.file).to_f/1024/1024
    end
    min = (length/60).to_i
    sec = sprintf("%02d", length - 60*min.to_f)
    "#{min}'#{sec}\""
  end

end
