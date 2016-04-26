class RecommendsController < ApplicationController
  def create
    LinkRecommender.recommend(current_user, params[:email]).deliver_now
    flash[:notice] = "Successfully recommended this link."
    redirect_to root_url
  end
end