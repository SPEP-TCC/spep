require "time"
class AulasController < ApplicationController
  before_action :set_aula, only: %i[ show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @instituicao = Instituicao.find(1)
    @dias = (1..5).to_a # Segunda a sexta
    @horarios = calcular_horarios(@instituicao.horario_inicio_aula, @instituicao.duracao_aula, @instituicao.horario_fim_aulas)

    @aulas = Aula.includes(:grade_curricular, :ambiente)
                 .where(ambiente: { instituicao_id: @instituicao.id })

    @grades_curriculares = GradeCurricular.joins(matriz_curricular_aplicada: { curso: :instituicao })
                                          .where(instituicoes: { id: @instituicao.id })
    @ambientes = Ambiente.where(instituicao_id: 1).select(:id, :descricao).to_json
    render layout: false
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
      render json: @aula.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if @aula.update(aula_params)
      redirect_to aulas_path, notice: t("messages.updated_successfully"), status: :see_other
    else
      render json: @aula.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    if @aula.destroy
      redirect_to aulas_url, notice: t("messages.deleted_successfully")
    else
      render json: @aula.errors.full_messages, status: :unprocessable_entity
    end
  end


  def calcular_horarios(horario_inicio, duracao_aula, ultima_aula)
    horarios = []
    horario_atual = Time.parse(horario_inicio)
    ultima_aula = Time.parse(ultima_aula)

    while horario_atual < ultima_aula
      horarios << horario_atual.strftime("%H:%M") # Format as HH:MM
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
