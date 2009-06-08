require 'soundcloud'

class PublicController < ApplicationController

	layout 'alfadeo'

  def index
    sc_client = Soundcloud.register
    @playlists = sc_client.User.find('Alfadeo').playlists
  end

  def show
    sc_client = Soundcloud.register
    @playlist = sc_client.Playlist.find(params[:id])
  end

	def play
		m3u = ''
    sc_client = Soundcloud.register
    playlist = sc_client.Playlist.find(params[:id])
		tracks = playlist.tracks
		tracks.each do |track|
      m3u = m3u + track.download_url + "\n"
		end
		send_data m3u, :filename => "#{playlist.title}.m3u", :type => 'audio/mpegurl'
	end

  def rss
    @releases = Release.find(:all, :conditions => ['publish = ?',true]).sort{|a,b| a.position <=> b.position}
    render :layout => false
  end

  def atom
    @releases = Release.find(:all, :conditions => ['publish = ?',true]).sort{|a,b| a.position <=> b.position}
    render :layout => false
  end

end
