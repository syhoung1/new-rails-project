class UsersController < ApplicationController
  def show
    @user = current_user
  end
  
  def update
    current_user.standard!
    current_user.wikis.update_all(private: false)
    redirect_to user_path
  end
end
