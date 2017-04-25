class CollaboratorsController < ApplicationController
  def new
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.find_by(email: params[:email])
    @collaborator = @wiki.collaborators.new(user: @user)

    if @user.nil?
      flash[:alert] = "There is no user by that email"
      redirect_to new_wiki_collaborator_path(@wiki)
    elsif @wiki.users.include?(@user)
      flash[:alert] = "There is already a collaborator by that email"
      redirect_to new_wiki_collaborator_path(@wiki)
    else
      if @collaborator.save
        flash[:notice] = "#{@user.email} has been added as a collaborator!"
      else
        flash[:alert] = "There was an error adding your collaborator"
      end
      redirect_to @wiki
    end
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find(params[:id])
    
    if @collaborator.destroy
      flash[:notice] = "This user has been removed as a collaborator"
      redirect_to @wiki
    else
      flash[:alert] = "There was an error removing this user"
    end
  end
end
