require "mp3info"

class Track < ActiveRecord::Base

  belongs_to :release
  file_column :file

  before_save :set_mp3_tags

  def set_mp3_tags
    Mp3Info.open(self.file) do |mp3|
      mp3.tag2.TALB = self.release.name 
      mp3.tag2.TCOP = "Creative Commons License http://creativecommons.org/licenses/by-sa/3.0/"
      mp3.tag2.TLEN = mp3.length
      mp3.tag2.TYER = self.release.date.year
      mp3.tag2.TIT2 = self.name
      mp3.tag2.TOWN = 'alfadeo'
      mp3.tag2.TCOM = 'alfadeo'
      mp3.tag2.TRCK = self.release.position
      mp3.tag2.WOAR = "http://www.alfadeo.de"
    end
  end

  def duration
    min = (length/60).to_i
    sec = sprintf("%02d", length - 60*min.to_f)
    "#{min}'#{sec}\""
  end

end
