class UtensilsController < ApplicationController
  before_action :authenticate_user!, except: [:search]
  before_action :set_recipe, except: [:search]
  before_action :set_utensil, only: [:show, :edit, :update, :destroy]

  # GET /utensils
  # GET /utensils.json
  def index
    @utensils = @recipe.utensils
  end

  # GET /utensils/1
  # GET /utensils/1.json
  def show
  end

  # GET /utensils/new
  def new
    @utensil = Utensil.new
  end

  # GET /utensils/1/edit
  def edit
  end

  # POST /utensils
  # POST /utensils.json
  def create
    @utensil = Utensil.new(utensil_params)
    @utensil.recipe = @recipe

    respond_to do |format|
      if @utensil.save
        format.html { redirect_to recipe_utensil_path(@recipe, @utensil), notice: 'Utensil was successfully created.' }
        format.json { render :show, status: :created, location: @utensil }
      else
        format.html { render :new }
        format.json { render json: @utensil.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /utensils/1
  # PATCH/PUT /utensils/1.json
  def update
    respond_to do |format|
      if @utensil.update(utensil_params)
        format.html { redirect_to recipe_utensil_path(@recipe, @utensil), notice: 'Utensil was successfully updated.' }
        format.json { render :show, status: :ok, location: @utensil }
      else
        format.html { render :edit }
        format.json { render json: @utensil.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /utensils/1
  # DELETE /utensils/1.json
  def destroy
    @utensil.destroy
    respond_to do |format|
      format.html { redirect_to recipe_utensils_path(@recipe), notice: 'Utensil was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    # @recipes = Utensil.where('name like ?', params[:q]).select(:recipe_id).map(&:recipe).sort_by{|r| r.name}
    @recipes = Recipe.where(id: Utensil.where('name like ?', "%#{params[:q]}%").pluck(:recipe_id))
    if current_user
      @recipes = @recipes.where(privacy: %w(public internal)).or(Recipe.where(author: current_user))
    else
      @recipes = @recipes.where(privacy: 'public')
    end
    @recipes = @recipes.select(:id, :name)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_utensil
      @utensil = @recipe.utensils.find_by(id: params[:id])
      redirect_to recipe_utensils_path(@recipe), flash: { alert: "Utensil #{params[:id]} not found for #{@recipe.name}" } and return if @utensil.nil?
    end

    def set_recipe
      @recipe = current_user.recipes.find_by(id: params[:recipe_id])
      redirect_to recipes_path, flash: { alert: "Recipe #{params[:recipe_id]} not found." } and return if @recipe.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def utensil_params
      params.require(:utensil).permit(:recipe_id, :name, :qty)
    end
end
