class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_recipe, only: [:show, :edit, :update, :destroy, :categories]

  # GET /recipes
  # GET /recipes.json
  def index
    if current_user
      @recipes = Recipe.where(privacy: %w(public internal)).or(Recipe.where(author: current_user))
    else
      @recipes = Recipe.public_recipes
    end
    @per_page = (params[:per_page] ? params[:per_page] : 50)
    respond_to do |format|
      format.html do
        @recipes = @recipes.paginate(page: params[:page], per_page: @per_page)
      end
      format.json do
        data = @recipes.as_json(include: [
                                        categories: {only: [:id]}
                                      ])
        data.map{ |r| r['categories'] = r['categories'].map{ |c| c['id'] } }
        render json: data
      end
    end
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
    redirect_to recipes_path, flash: { alert: "You are not permitted to see recipe #{@recipe.id}" } and return if @recipe.privacy == 'private' and @recipe.author != current_user
    respond_to do |format|
      format.html {}
      format.json do
        render json: @recipe.as_json(include: [
                          author: {only: [:id, :name]},
                          ingredients: {only: [:id, :qty, :unit, :item, :note]},
                          utensils: {only: [:id, :qty, :name]},
                          directions: {only: [:id, :step, :action]},
                        ])
      end
    end
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
    redirect_to recipes_path, flash: {alert: 'You do not have permission to edit that recipe.'} and return if @recipe.author != current_user
    @picture = Picture.new(recipe: @recipe)
    @ingredient = Ingredient.new(recipe: @recipe)
    @utensil = Utensil.new(recipe: @recipe)
    @direction = Direction.new(recipe: @recipe)
    render :show
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.author = current_user

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to edit_recipe_path(@recipe), notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    redirect_to root_path and return if @recipe.author != current_user
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    redirect_to root_path and return if @recipe.author != current_user
    @recipe.utensils.destroy_all
    @recipe.ingredients.destroy_all
    @recipe.directions.destroy_all
    @recipe.pictures.destroy_all
    @recipe.categories.destroy_all
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # PUT /recipes/1/categories.json
  def categories
    redirect_to root_path and return if @recipe.author != current_user
    ActiveRecord::Base.transaction do
      @recipe.categories.delete_all
      params[:cid].each do |cid|
        RecipeCategory.create(recipe: @recipe, category_id: cid)
      end
    end
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'This is an API path.' }
      format.json { render json: @recipe.categories.select(:name) }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find_by(id: params[:id])
      if @recipe.nil?
        respond_to do |format|
          format.html { super }
          format.json { render json: {errors: ['Recipe not found']}, status: :not_found}
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:name, :author, :servings, :serving_suggestion, :rating, :privacy, :categories, directions_attributes: [:id, :step, :action], ingredients_attributes: [:id, :qty, :unit, :item, :note], utensils_attributes: [:name, :qty])
    end
end
