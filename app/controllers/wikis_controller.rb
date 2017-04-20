class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def create
    @wiki = Wiki.new(wiki_params)
    
    if @wiki.save
      redirect_to @wiki, notice: "Your wiki post has been saved!"
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
  end

  def show
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
