class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def show
    load_article
  end

  def new
    @article = Article.new
  end

  def create
    article = Article.create(article_params)
    redirect_to article_path(article.slug)
  end

  def edit
    load_article
  end

  def update
    ##### WHYYYY DO I HAVE TO DO THIS?? HOW DO I SET PARAMS FROM THE FORM??
    params[:slug] = params[:article][:title].parameterize
    @article = Article.find_by(slug: params[:slug])
    @article.update(article_params)
    redirect_to articles_path
  end

  def destroy
    load_article
    @article.delete
    redirect_to articles_path
  end


private

  def load_article
    @article = Article.find_by(slug: params[:slug])
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end

end
