class GradesCurricularesController < ApplicationController
  before_action :set_grade_curricular, only: %i[ show edit update destroy ]

  # GET /grades_curriculares or /grades_curriculares.json
  def index
    @grades_curriculares = GradeCurricular.all
  end

  # GET /grades_curriculares/1 or /grades_curriculares/1.json
  def show
  end

  # GET /grades_curriculares/new
  def new
    @grade_curricular = GradeCurricular.new
  end

  # GET /grades_curriculares/1/edit
  def edit
  end

  # POST /grades_curriculares or /grades_curriculares.json
  def create
    @grade_curricular = GradeCurricular.new(grade_curricular_params)

    respond_to do |format|
      if @grade_curricular.save
        format.html { redirect_to @grade_curricular, notice: "Grade curricular was successfully created." }
        format.json { render :show, status: :created, location: @grade_curricular }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @grade_curricular.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grades_curriculares/1 or /grades_curriculares/1.json
  def update
    respond_to do |format|
      if @grade_curricular.update(grade_curricular_params)
        format.html { redirect_to @grade_curricular, notice: "Grade curricular was successfully updated." }
        format.json { render :show, status: :ok, location: @grade_curricular }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @grade_curricular.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grades_curriculares/1 or /grades_curriculares/1.json
  def destroy
    @grade_curricular.destroy!

    respond_to do |format|
      format.html { redirect_to grades_curriculares_path, status: :see_other, notice: "Grade curricular was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grade_curricular
      @grade_curricular = GradeCurricular.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def grade_curricular_params
      params.require(:grade_curricular).permit(:disciplina_id, :carga_horaria, :periodo_calendario, :optativa, :matriz_curricular_aplicada_id, :user_id, :created_by, :updated_by, :deleted_at)
    end
end
