class HomeController < ApplicationController
  def index
  end

  def search
    @q = params[:search]
    @results = {
      authors: User.where('name LIKE :q', {q: "%#{@q}%"}).select(:id, :name),
      recipes: Recipe.where('name LIKE :q', {q: "%#{@q}%"}).select(:id, :name),
      categories: Category.where('name LIKE ?', "%#{@q}%"),
      notes: Note.where('note like ?', "%#{@q}%").pluck(:note),
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
  end
end
