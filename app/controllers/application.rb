# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base

	layout 'alfadeo'
	private

	def authorize
		session[:original_uri] = request.request_uri
		unless User.find_by_id(session[:user_id])
			flash[:notice] = 'Please log in'
			redirect_to(:controller => 'login', :action => 'login')
		end
	end

end
