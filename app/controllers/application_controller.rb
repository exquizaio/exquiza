class ApplicationController < ActionController::Base
  helper ApplicationHelper
  before_action :authenticate_user!
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def successful_signin
    if current_user.admin?
      redirect_to questions_path
    else
      redirect_to tests_path
    end
  end

end
