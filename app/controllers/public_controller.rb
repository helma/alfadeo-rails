class PublicController < ApplicationController

	layout 'alfadeo'

  def index
    @releases = Release.find(:all, :conditions => ['publish = ?',true]).sort{|a,b| a.position <=> b.position}
  end

  def show
    @release = Release.find(params[:id])
  end

	def play
		m3u = ''
    release = Release.find(params[:id])
		tracks = release.sorted_tracks
		tracks.each do |track|
      host = request.host + ':' + request.port.to_s
      url = "http://"+host+"/track/file/"+track.file_relative_path
      m3u = m3u + url + "\n"
		end
		send_data m3u, :filename => "#{release.name}.m3u", :type => 'audio/mpegurl'
	end

=begin
  def resize
     width, height = 100, 100

     img =  Magick::Image.read('tmp.jpg').first
     thumb = img.resize(width, height)
     
     # If you want to save this image use following
     # thumb.write("mythumbnail.jpg")

     # otherwise send it to the browser as follows
     send_data(thumb.to_blob, :disposition => 'inline', 
                            :type => 'image/jpg')
   end
=end

end
