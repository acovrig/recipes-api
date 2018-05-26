class DirectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe
  before_action :set_direction, only: [:show, :edit, :update, :destroy]

  # GET /directions
  # GET /directions.json
  def index
    @directions = @recipe.directions
  end

  # GET /directions/1
  # GET /directions/1.json
  def show
  end

  # GET /directions/new
  def new
    @direction = Direction.new
  end

  # GET /directions/1/edit
  def edit
  end

  # POST /directions
  # POST /directions.json
  def create
    @direction = Direction.new(direction_params)
    @direction.recipe = @recipe
    last = @recipe.directions.order(step: :asc).last
    @direction.step = (last.nil? ? 0 : last.id) + 1 if @direction.step.nil?
    respond_to do |format|
      if @direction.save
        format.html { redirect_to recipe_direction_path(@recipe, @direction), notice: 'Direction was successfully created.' }
        format.json { render json: @direction }
      else
        format.html { render :new }
        format.json { render json: @direction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /directions/1
  # PATCH/PUT /directions/1.json
  def update
    respond_to do |format|
      if @direction.update(direction_params)
        format.html { redirect_to recipe_direction_path(@recipe, @direction), notice: 'Direction was successfully updated.' }
        format.json { render :show, status: :ok, location: @direction }
      else
        format.html { render :edit }
        format.json { render json: @direction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /directions/1
  # DELETE /directions/1.json
  def destroy
    @direction.destroy
    respond_to do |format|
      format.html { redirect_to recipe_directions_path(@recipe), notice: 'Direction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_direction
      @direction = @recipe.directions.find_by(id: params[:id])
      redirect_to recipe_directions_path(@recipe), flash: { alert: "Direction #{params[:id]} not found for #{@recipe.name}" } and return if @direction.nil?
    end

    def set_recipe
      @recipe = current_user.recipes.find_by(id: params[:recipe_id])
      redirect_to recipes_path, flash: { alert: "Recipe #{params[:recipe_id]} not found." } and return if @recipe.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def direction_params
      params.require(:direction).permit(:step, :action)
    end
end
