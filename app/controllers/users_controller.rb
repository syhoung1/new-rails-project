class UsersController < ApplicationController
  def show
    @user = current_user
  end
  
  def update
    current_user.standard!
    redirect_to user_path
  end
end
