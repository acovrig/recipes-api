class HomeController < ApplicationController
  def index
    redirect_to recipes_path if user_signed_in?
  end

  def search
    @q = params[:search]
    ingredients = params[:ingredients].split(',') if params[:ingredients]
    utensils = params[:utensils].split(',') if params[:utensils]
    if !@q.nil?
      @results = {
        authors: User.where('name LIKE :q', { q: "%#{@q}%" }).select(:id, :name),
        recipes: Recipe.where('name LIKE :q', { q: "%#{@q}%" }).select(:id, :name),
        categories: Category.where('name LIKE ?', "%#{@q}%"),
        utensils: Utensil.where('name like ?', "%#{@q}%").distinct.pluck(:name),
        ingredients: Ingredient.where('item like ?', "%#{@q}%").distinct.pluck(:item)
      }
    elsif !(ingredients.nil? && utensils.nil?)
      ids = []
      ids += Ingredient.where('item in (?)', ingredients).pluck(:recipe_id)
      ids += Utensil.where('name in (?)', utensils).pluck(:recipe_id)
      @results = {
        recipes: Recipe.where('id in (?)', ids).select(:id, :name)
      }
      if params[:match] == 'all'
        nids = []
        @results[:recipes].each do |recipe|
          recipe.ingredients.pluck(:item).each do |ingredient|
            nids << recipe.id unless ingredients.include? ingredient
          end
          recipe.utensils.pluck(:name).each do |utensil|
            nids << recipe.id unless utensils.include? utensil
          end
        end
        @results[:recipes] = @results[:recipes].where('id NOT IN (?)', nids)
      end
    end
    @results[:recipes] = if user_signed_in?
                           @results[:recipes].where('privacy IN (?) OR author_id = ?', %w[public internal], current_user.id)
                         else
                           @results[:recipes].where(privacy: 'public')
                         end
    @results[:recipes].order(name: :asc)

    respond_to do |format|
      format.html { render :search }
      format.json { render json: @results and return }
    end
  end

  def inventory
    @ingredients = Ingredient.select(:id, :item).order(item: :asc).uniq(&:item)
    @utensils = Utensil.select(:id, :name).order(name: :asc).uniq(&:name)
  end

  def author
    @user = User.find_by(id: params[:id])
    redirect_to root_path, flash: { alert: "Author #{params[:id]} not found." } and return if @user.nil?

    @recipes = Recipe.where(author: @user)
    @recipes = if user_signed_in?
                 @recipes.where('privacy IN (?) OR author_id = ?', %w[public internal], current_user.id)
               else
                 @recipes.where(privacy: 'public')
               end
    @per_page = (params[:per_page] || 50)
    @recipes = @recipes.paginate(page: params[:page], per_page: @per_page)
  end
end
