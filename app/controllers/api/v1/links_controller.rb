class Api::V1::LinksController < ApplicationController
  respond_to :json

  def show
    @link = Link.find(params[:id])
    respond_with @link
  end

  def index
    if current_user
      @links = current_user.links
      respond_with @links
    else
      respond_to do |format|
        format.json { render json: 'Hi' }
      end
    end
  end

  def update
    link = Link.find(params[:id])
    link.read_status = new_status(link) if params[:change_type]
    link.save
    respond_to do |format|
      format.json { render json: link }
    end
  end

  private

  def new_status(link)
    link.read_status == true ? false : true
  end
end