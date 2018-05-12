class IngredientsController < ApplicationController
  before_action :authenticate_user!, except: [:search]
  before_action :set_recipe, except: [:search]
  before_action :set_ingredient, only: [:show, :edit, :update, :destroy]

  # GET /ingredients
  # GET /ingredients.json
  def index
    @ingredients = @recipe.ingredients
  end

  # GET /ingredients/1
  # GET /ingredients/1.json
  def show
  end

  # GET /ingredients/new
  def new
    @ingredient = Ingredient.new
  end

  # GET /ingredients/1/edit
  def edit
  end

  # POST /ingredients
  # POST /ingredients.json
  def create
    @ingredient = Ingredient.new(ingredient_params)
    @ingredient.recipe = @recipe

    respond_to do |format|
      if @ingredient.save
        format.html { redirect_to recipe_ingredient_path(@recipe, @ingredient), notice: 'Ingredient was successfully created.' }
        format.json { render :show, status: :created, location: @ingredient }
      else
        format.html { render :new }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ingredients/1
  # PATCH/PUT /ingredients/1.json
  def update
    respond_to do |format|
      if @ingredient.update(ingredient_params)
        format.html { redirect_to recipe_ingredient_path(@recipe, @ingredient), notice: 'Ingredient was successfully updated.' }
        format.json { render :show, status: :ok, location: @ingredient }
      else
        format.html { render :edit }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredients/1
  # DELETE /ingredients/1.json
  def destroy
    @ingredient.destroy
    respond_to do |format|
      format.html { redirect_to recipe_ingredients_path(@recipe), notice: 'Ingredient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    @recipes = Ingredient.where('item like ?', params[:q]).select(:recipe_id).map(&:recipe).sort_by{|r| r.name}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingredient
      @ingredient = @recipe.ingredients.find_by(id: params[:id])
      redirect_to recipe_ingredients_path(@recipe), flash: { alert: "Ingredient #{params[:id]} not found for #{@recipe.name}" } and return if @ingredient.nil?
    end

    def set_recipe
      @recipe = current_user.recipes.find_by(id: params[:recipe_id])
      redirect_to recipes_path, flash: { alert: "Recipe #{params[:recipe_id]} not found." } and return if @recipe.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ingredient_params
      params.require(:ingredient).permit(:recipe_id, :qty, :unit, :item, :note)
    end
end
