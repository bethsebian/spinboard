class LinksController < ApplicationController
  def index
    @link = Link.new
    @links = User.find(current_user.id).links if current_user
  end

  def create
    @link = Link.new(link_params)
    if !current_user
      flash[:notice] = "Please log in to add a link."
      redirect_to links_path
    elsif @link.save && current_user
      redirect_to links_path
    else
      flash[:notice] = "The url is invalid. Please try again."
      redirect_to links_path
    end
  end

  private

  def link_params
    params.require(:link).permit(:url, :title, :user_id)
  end
end