require "time"
class AulasController < ApplicationController
  before_action :set_aula, only: %i[ show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @instituicao = Instituicao.find(1)
    @dias = { 1 => "Segunda-Feira", 2 => "Terça-Feira", 3 => "Quarta-Feira", 4 => "Quinta-Feira", 5 => "Sexta-Feira" }.to_json
    @horarios = calcular_horarios(@instituicao.horario_inicio_aula, @instituicao.duracao_aula, @instituicao.horario_fim_aulas)
    @professores = User.joins(:tipo_contrato).select("users.id", "users.nome AS name",
                                            "(tipos_contratos.carga_horaria * 60) AS weeklyMinutes").to_json

    @grades_curriculares = GradeCurricular.joins(:disciplina, :ambiente).select(
                                                                        "grades_curriculares.id,
                                                                        disciplinas.descricao AS name,
                                                                        ambientes.descricao AS room,
                                                                        (grades_curriculares.carga_horaria * 60) AS weeklyMinutes"
                                                                      ).to_json


    @aulas = Aula.includes(:grade_curricular, :ambiente)
                 .where(ambiente: { instituicao_id: @instituicao.id })
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

  def calcular_minutos_ch(min)
    min = min * 60
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
