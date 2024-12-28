class SubareasController < ApplicationController
  before_action :set_subarea, only: %i[ show edit update destroy ]

  # GET /subareas or /subareas.json
  def index
    @subareas = Subarea.all
  end

  # GET /subareas/1 or /subareas/1.json
  def show
  end

  # GET /subareas/new
  def new
    @subarea = Subarea.new
  end

  # GET /subareas/1/edit
  def edit
  end

  # POST /subareas or /subareas.json
  def create
    @subarea = Subarea.new(subarea_params)

    respond_to do |format|
      if @subarea.save
        format.html { redirect_to @subarea, notice: "Subarea was successfully created." }
        format.json { render :show, status: :created, location: @subarea }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @subarea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subareas/1 or /subareas/1.json
  def update
    respond_to do |format|
      if @subarea.update(subarea_params)
        format.html { redirect_to @subarea, notice: "Subarea was successfully updated." }
        format.json { render :show, status: :ok, location: @subarea }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subarea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subareas/1 or /subareas/1.json
  def destroy
    @subarea.destroy!

    respond_to do |format|
      format.html { redirect_to subareas_path, status: :see_other, notice: "Subarea was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subarea
      @subarea = Subarea.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def subarea_params
      params.require(:subarea).permit(:descricao, :area_id, :created_by, :updated_by, :deleted_at)
    end
end
