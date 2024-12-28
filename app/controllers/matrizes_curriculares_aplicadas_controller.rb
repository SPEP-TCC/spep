class MatrizesCurricularesAplicadasController < ApplicationController
  before_action :set_matriz_curricular_aplicada, only: %i[ show edit update destroy ]

  # GET /matrizes_curriculares_aplicadas or /matrizes_curriculares_aplicadas.json
  def index
    @matrizes_curriculares_aplicadas = MatrizCurricularAplicada.all
  end

  # GET /matrizes_curriculares_aplicadas/1 or /matrizes_curriculares_aplicadas/1.json
  def show
  end

  # GET /matrizes_curriculares_aplicadas/new
  def new
    @matriz_curricular_aplicada = MatrizCurricularAplicada.new
  end

  # GET /matrizes_curriculares_aplicadas/1/edit
  def edit
  end

  # POST /matrizes_curriculares_aplicadas or /matrizes_curriculares_aplicadas.json
  def create
    @matriz_curricular_aplicada = MatrizCurricularAplicada.new(matriz_curricular_aplicada_params)

    respond_to do |format|
      if @matriz_curricular_aplicada.save
        format.html { redirect_to @matriz_curricular_aplicada, notice: "Matriz curricular aplicada was successfully created." }
        format.json { render :show, status: :created, location: @matriz_curricular_aplicada }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @matriz_curricular_aplicada.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /matrizes_curriculares_aplicadas/1 or /matrizes_curriculares_aplicadas/1.json
  def update
    respond_to do |format|
      if @matriz_curricular_aplicada.update(matriz_curricular_aplicada_params)
        format.html { redirect_to @matriz_curricular_aplicada, notice: "Matriz curricular aplicada was successfully updated." }
        format.json { render :show, status: :ok, location: @matriz_curricular_aplicada }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @matriz_curricular_aplicada.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matrizes_curriculares_aplicadas/1 or /matrizes_curriculares_aplicadas/1.json
  def destroy
    @matriz_curricular_aplicada.destroy!

    respond_to do |format|
      format.html { redirect_to matrizes_curriculares_aplicadas_path, status: :see_other, notice: "Matriz curricular aplicada was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_matriz_curricular_aplicada
      @matriz_curricular_aplicada = MatrizCurricularAplicada.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def matriz_curricular_aplicada_params
      params.require(:matriz_curricular_aplicada).permit(:descricao, :ano_letivo, :turno_id, :curso_id, :ativo, :created_by, :updated_by, :deleted_at)
    end
end
