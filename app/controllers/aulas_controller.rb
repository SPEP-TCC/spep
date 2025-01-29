class AulasController < ApplicationController
  before_action :set_aula, only: %i[ show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @instituicao = Instituicao.find(1)
    @dias = (1..5).to_a # Segunda a sexta
    @horarios = calcular_horarios(@instituicao.horario_inicio_aulas, @instituicao.duracao_aula, @instituicao.horario_fim_aulas)

    @aulas = Aula.includes(:grade_curricular, :ambiente)
                 .where(ambiente: { instituicao_id: @instituicao.id })

    @grades_curriculares = GradeCurricular.joins(matriz_curricular_aplicada: { curso: :instituicao })
                                          .where(instituicoes: { id: @instituicao.id })
  end

  def new
    @aula = Aula.new
  end

  def edit
  end

  def create
    @aula = Aula.new(aula_params)

    if @aula.save
      redirect_to aulas_path, notice: t("messages.created_successfully")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @aula.update(aula_params)
      redirect_to aulas_path, notice: t("messages.updated_successfully"), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @aula.destroy
      redirect_to aulas_url, notice: t("messages.deleted_successfully")
    else
      redirect_to aulas_url, alert: t("messages.delete_failed_due_to_dependencies")
    end
  end

  def calcular_horarios(horario_inicio, duracao_aula, ultima_aula)
    horarios = []
    horario_atual = horario_inicio
    while horario_atual < ultima_aula
      horarios << horario_atual
      horario_atual += duracao_aula.minutes
    end
    horarios
  end

  private

  def set_aula
    @aula = Aula.find_by(id: params[:id])
    redirect_to aulas_path, alert: t("messages.not_found") unless @aula
  end

  def aula_params
    permitted_attributes = Aula.column_names.reject { |col| [ "deleted_at", "created_by", "updated_by" ].include?(col) }
    params.require(:aula).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to aulas_path, alert: t("messages.not_found")
  end
end
