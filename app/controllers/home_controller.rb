class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to recipes_path
    end
  end # index

  def search
    @q = params[:search]
    @results = {
      authors: User.where('name LIKE :q', {q: "%#{@q}%"}).select(:id, :name),
      recipes: Recipe.where('name LIKE :q', {q: "%#{@q}%"}).select(:id, :name),
      categories: Category.where('name LIKE ?', "%#{@q}%"),
      utensils: Utensil.where('name like ?', "%#{@q}%").distinct.pluck(:name),
      ingredients: Ingredient.where('item like ?', "%#{@q}%").distinct.pluck(:item)
    }
    if user_signed_in?
      @results[:recipes] = @results[:recipes].where('privacy IN (?) OR author_id = ?', %w(public internal), current_user.id)
    else
      @results[:recipes] = @results[:recipes].where(privacy: 'public')
    end

    respond_to do |format|
      format.html {}
      format.json { render json: @results and return }
    end
  end # search

  def author
    @user = User.find_by(id: params[:id])
    redirect_to root_path, flash: { alert: "Author #{params[:id]} not found." } and return if @user.nil?
    @recipes = Recipe.where(author: @user)
    if user_signed_in?
      @recipes = @recipes.where('privacy IN (?) OR author_id = ?', %w(public internal), current_user.id)
    else
      @recipes = @recipes.where(privacy: 'public')
    end
    @per_page = (params[:per_page] ? params[:per_page] : 50)
    @recipes = @recipes.paginate(page: params[:page], per_page: @per_page)
  end # author
end
