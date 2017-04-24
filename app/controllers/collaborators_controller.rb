class CollaboratorsController < ApplicationController
  def new
    @wiki = Wiki.find(params[:wiki_id])
    # collaborator = Collaborator.new
  end

  def create
    @wiki = Wiki.find(params[:id])
    @user = User.find(params[:collaborator][:user_id])
    @collaborator = Collaborator.new
    @collaborator.wiki_id = @wiki.id
    @wiki.collaborators << collaborator
    
    invalid_user?(@wiki, @user)
    
    if @collaborator.save
      flash[:notice] = "The account at #{User.find_by(user_id: @collaborator.user_id).email} has been added as a collaborator!"
    else
      flash[:alert] = "There was an error adding your collaborator"
    end
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    
    if @collaborator.destroy
      flash[:notice] = "This user has been removed as a collaborator"
      redirect_to @wiki
    else
      flash[:alert] = "There was an error removing this user"
    end
  end
  
  def collaborators_user
    params.require(:collaborator).permit(:user_id)
  end
  
  def invalid_user?(wiki, user)
    if !User.include?(user)
      flash[:alert] = "There is no user by that email!"
      render :new
    elsif user.wiki_ids.include?(wiki.id)
      flash[:alert] = "That user is already a collaborator for this post!"
      render :new
    end
  end
end