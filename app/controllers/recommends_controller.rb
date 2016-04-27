class RecommendsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    LinkRecommender.recommend(params[:email], params[:link_id]).deliver_now
    flash[:notice] = "Successfully recommended this link."
    redirect_to root_url
  end
end