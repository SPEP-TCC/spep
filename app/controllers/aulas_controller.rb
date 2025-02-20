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

    @grades_curriculares = GradeCurricularTurma.joins(:turma, grade_curricular: [ :disciplina, :ambiente ])
                                                .select(
                                                        "grades_curriculares.id",
                                                        "disciplinas.descricao AS name",
                                                        "ambientes.id AS room_id",
                                                        "ambientes.descricao AS room",
                                                        "turmas.id AS turma_id",
                                                        "turmas.descricao AS turma",
                                                        "(grades_curriculares.carga_horaria * 60) AS weeklyminutes"
                                                ).to_json
    assignments = Aula.joins(
     "INNER JOIN grades_curriculares ON grades_curriculares.id = aulas.grade_curricular_id
      INNER JOIN disciplinas ON disciplinas.id = grades_curriculares.disciplina_id
      INNER JOIN turmas ON turmas.id = aulas.turma_id
      INNER JOIN users ON users.id = aulas.user_id
      INNER JOIN tipos_contratos ON users.tipo_contrato_id = tipos_contratos.id"
      ).select(
        "turmas.id AS turma_id",
        "aulas.dia AS dia",
        "aulas.horario_inicio AS horario_inicio",
        "aulas.id AS aula_id",
        "disciplinas.id AS disciplina_id",
        "disciplinas.descricao AS disciplina_descricao",
        "grades_curriculares.carga_horaria AS disciplina_carga_horaria",
        "aulas.user_id AS teacher_id",
        "users.nome AS teacher_nome",
        "tipos_contratos.carga_horaria AS teacher_carga_horaria"
      )

      @saved_assignments = assignments.map do |assignment|
        # Compute max uses based on carga_horaria (assuming a 50-minute block)
        subject_max_uses = (assignment.disciplina_carga_horaria.to_f / 50).floor
        teacher_max_uses = (assignment.teacher_carga_horaria.to_f / 50).floor

        {
          turma_id: assignment.turma_id,
          dia: assignment.dia,
          horario_inicio: assignment.horario_inicio,
          aula_id: assignment.aula_id,
          subject: {
            id: assignment.disciplina_id,
            descricao: assignment.disciplina_descricao,
            carga_horaria: assignment.disciplina_carga_horaria,
            max_uses: subject_max_uses
            # You can calculate current uses on the fly or later, if needed
          },
          teacher: {
            id: assignment.teacher_id,
            nome: assignment.teacher_nome,
            carga_horaria: assignment.teacher_carga_horaria,
            max_uses: teacher_max_uses
            # Similarly, current uses could be computed or added if needed
          }
        }
      end
  end

  def new
    @aula = Aula.new
  end

  def edit
  end

  def create
    @aula = Aula.new(aula_params)
    respond_to do |format|
      if @aula.save
        # Wrap the id in a JSON object
        format.json { render json: { id: @aula.id }, status: :ok }
      else
        format.json { render json: @aula.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @aula.update(aula_params)
        format.json { render json: { id: @aula.id }, status: :ok }
      else
        format.json { render json: @aula.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @aula.destroy
      render json: { message: t("messages.deleted_successfully") }, status: :ok
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
