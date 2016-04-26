module HomeHelper
  def authenticate_user!
    if logged_in?
    else
      flash[:error] = 'Please log in to continue'
      redirect_to login_path
    end
  end
end