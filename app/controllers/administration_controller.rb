class AdministrationController < ApplicationController

  before_filter :authorize

  active_scaffold :release do |config|
    config.actions << :sortable
    config.action_links.add 'preview', :type => :record ,:page => true, :label => 'Preview'
    config.action_links.add 'home',:page => true, :label => 'Home'
    config.show.link = false 
    config.columns = ['publish', 'name', 'description', 'image', 'tracks', 'date']
    columns[:publish].form_ui = :checkbox
    columns[:description].form_ui = :textarea
  end

  def preview
    @release = Release.find(params[:id])
  end

  def home
    redirect_to :controller => :public
  end

  def publish
    Release.find(params[:id]).update_attribute(:publish,true)
    redirect_to :controller => :public
  end

end
