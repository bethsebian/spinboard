class HomeController < ApplicationController
  include HomeHelper
  before_action :authenticate_user!

  def index
  end

end