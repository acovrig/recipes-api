class HomeController < ApplicationController
  def index
  end

  def search
    @results = {
      recipes: Recipe.where('name LIKE :q OR author LIKE :q', {q: "%#{params[:search]}%"}).select(:id, :name),
      categories: Category.where('name LIKE ?', "%#{params[:search]}%"),
      notes: Note.where('note like ?', "%#{params[:search]}%").pluck(:note),
      utensils: Utensil.where('name like ?', "%#{params[:search]}%").distinct.pluck(:name),
      ingredients: Ingredient.where('item like ?', "%#{params[:search]}%").distinct.pluck(:item)
    }

    redirect_to @results[:recipes].first if @results[:recipes].length == 1 and
      @results[:categories].length == 0 and
      @results[:notes].length == 0 and
      @results[:utensils].length == 0 and
      @results[:ingredients].length == 0
    
    redirect_to @results[:categories].first if @results[:categories].length == 1 and
      @results[:recipes].length == 0 and
      @results[:notes].length == 0 and
      @results[:utensils].length == 0 and
      @results[:ingredients].length == 0
    
    redirect_to @results[:notes].first if @results[:notes].length == 1 and
      @results[:recipes].length == 0 and
      @results[:categories].length == 0 and
      @results[:utensils].length == 0 and
      @results[:ingredients].length == 0
  
    redirect_to @results[:utensils].first if @results[:utensils].length == 1 and
      @results[:recipes].length == 0 and
      @results[:notes].length == 0 and
      @results[:categories].length == 0 and
      @results[:ingredients].length == 0

    redirect_to @results[:ingredients].first if @results[:ingredients].length == 1 and
      @results[:recipes].length == 0 and
      @results[:notes].length == 0 and
      @results[:utensils].length == 0 and
      @results[:categories].length == 0

    respond_to do |format|
      format.html {}
      format.json { render json: @results and return }
    end
  end
end
