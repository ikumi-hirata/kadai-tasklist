class ApplicationController < ActionController::Base
  include SessionsHelper
  
  private
  
  def require_user_loggen_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  #タスクの数をカウント
  #def counts(user)
  #  @count_tasks = user.tasks.count
  #end
end
