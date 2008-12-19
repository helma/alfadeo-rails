class PublicController < ApplicationController

  def index
    @releases = Release.find(:all).sort{|a,b| a.position <=> b.position}
  end

  def show
    @release = Release.find(params[:id])
  end

end
