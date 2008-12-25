class TracksController < ApplicationController

  active_scaffold :track do |config|
    config.actions << :sortable
    config.show.link = false 
    config.columns = ['name', 'file']
  end

=begin
	#layout 'alfadeo'
	#model :selection

  def index
		session[:selection] = Selection.new if session[:selection].blank?
		session[:format] = params[:format] unless params[:format].blank?
		session[:format] = 'mp3' if session[:format].blank?
		@selection_size = session[:selection].size(session[:format])
	end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

	def download
		t = Track.find(params[:id])
		if params[:format].blank?
			format = session[:format]
		else
			format = params[:format]
		end
		file = t.get_path(format)
		if format == 'mp3'
			mime_type = 'audio/mpeg'
		elsif format == 'ogg'
			mime_type = 'application/' + format
		end
		filename = t.file(format)
		send_file file, :filename => filename, :type => mime_type, :stream => false
	end

	def play
		t = Track.find(params[:id])
		if params[:format].blank?
			format = session[:format]
		else
			format = params[:format]
		end
		host = request.host + ':' + request.port.to_s
		url = t.get_url(host,format,params[:id])
		m3u = t.displayed_name + '.m3u'
		send_data url, :filename => m3u, :type => 'audio/mpegurl'
	end

	def download_all
		zip_file = 'alfadeo-' + params[:collection].pluralize + '-' + session[:format] + '.zip'
		zip_path = RAILS_ROOT + '/public/tracks/' +  zip_file
		send_file zip_path, :filename => zip_file, :type => 'application/zip', :stream => false
	end

	def download_selection
		zip_file = 'tmp/tmp' + session.object_id.to_s + '.zip'
		files = ''
		Track.find(session[:selection].get_selection).each do |track|
			files = files + ' ' + track.get_path(session[:format])
			`zip -j #{zip_file} #{files}`
		end
		send_file zip_file, :filename => 'alfadeo.zip', :type => 'application/zip',  :stream => false
		`rm zip_file`
	end

	def play_selection
		m3u = ''
		Track.find(session[:selection].get_selection).each do |track|
			host = request.host + ':' + request.port.to_s
			url = track.get_url(host,session[:format],track.id.to_s)
			m3u = m3u + url + "\n"
		end
		send_data m3u, :filename => "alfadeo.m3u", :type => 'audio/mpegurl'
	end

	def toggle_selection
		session[:selection].toggle_selection(params[:id])
		redirect_to :controller => 'tracklist', :action => 'index'
	end

=end
end
