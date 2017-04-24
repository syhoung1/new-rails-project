class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
    @wiki = Wiki.first || Wiki.find(params[:id])
  end

  def create
    @wiki = current_user.wikis.new(wiki_params)

    unless current_user.admin? || current_user.premium?
      flash.now[:alert] = "You must be a premium subscriber to do that!"
      redirect_to @wiki && return
    end

    if @wiki.save
      redirect_to @wiki, notice: "Your wiki has been saved!"
    else
      flash[:alert] = "There was an error in saving your wiki!"
      render :new
    end
  end

  def new
    @wiki = Wiki.new
  end

  def edit
    @wiki = Wiki.find(params[:id])
    @collaborators = @wiki.collaborators

  end

  def show
    @wikis = Wiki.all
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.update_attributes(wiki_params)

    if @wiki.save
      redirect_to @wiki
    else
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      redirect_to action: :index
    else
      render :show
    end
  end

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end

end
