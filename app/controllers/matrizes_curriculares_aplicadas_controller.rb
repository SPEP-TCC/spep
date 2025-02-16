# frozen_string_literal: true

class MatrizesCurricularesAplicadasController < ApplicationController
  before_action :set_matriz_curricular_aplicada, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = MatrizCurricularAplicada.ransack(params[:q])
    @pagy, @matrizes_curriculares_aplicadas = pagy(@q.result)
  end

  def new
    @matriz_curricular_aplicada = MatrizCurricularAplicada.new
    @matriz_curricular_aplicada.grades_curriculares.new
  end

  def edit
    @matriz_curricular_aplicada.grades_curriculares.build
  end

  def create
    @matriz_curricular_aplicada = MatrizCurricularAplicada.new(matriz_curricular_aplicada_params)

    if @matriz_curricular_aplicada.save
      redirect_to matrizes_curriculares_aplicadas_path, notice: t("messages.created_successfully")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @matriz_curricular_aplicada.update(matriz_curricular_aplicada_params)
      redirect_to matrizes_curriculares_aplicadas_path, notice: t("messages.updated_successfully"), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @matriz_curricular_aplicada.destroy
      redirect_to matrizes_curriculares_aplicadas_url, notice: t("messages.deleted_successfully")
    else
      redirect_to matrizes_curriculares_aplicadas_url, alert: t("messages.delete_failed_due_to_dependencies")
    end
  end

  private

  def set_matriz_curricular_aplicada
    @matriz_curricular_aplicada = MatrizCurricularAplicada.find_by(id: params[:id])
    redirect_to matrizes_curriculares_aplicadas_path, alert: t("messages.not_found") unless @matriz_curricular_aplicada
  end

  def matriz_curricular_aplicada_params
    permitted_attributes = MatrizCurricularAplicada.column_names.reject { |col| [ "deleted_at", "created_by", "updated_by" ].include?(col) }
    params.require(:matriz_curricular_aplicada).permit(permitted_attributes.map(&:to_sym),
                                                       grades_curriculares_attributes: [ :id, :disciplina_id, :carga_horaria,
                                                      :periodo_calendario, :optativa, :carga_horaria_total ])
  end

  def handle_not_found
    redirect_to matrizes_curriculares_aplicadas_path, alert: t("messages.not_found")
  end
end
