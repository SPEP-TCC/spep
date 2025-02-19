require "time"

class Aula < ApplicationRecord
  belongs_to :grade_curricular
  belongs_to :ambiente

  ### adicionar user_id a aula
  before_save :ocupar_ambiente
  before_save :set_horario_fim
  validate :verify_aula_igual
  validate :verify_aula_professor_mesmo_horario
  validate :verify_aula_mesmo_horario
  validate :verify_aula_turmas
  validate :verificar_aula_noite
  validate :verificar_restricao_professor

  def ocupar_ambiente
    ambiente_ocupado = DisponibilidadeSala.find_by(ambiente_id: self.ambiente_id, dia: self.dia,
                        horario_inicio: self.horario_inicio, horario_fim: self.horario_fim
    )
    if ambiente_ocupado
      errors.add(:base, "Ambiente já ocupado para este dia e horário.")
    else
      DisponibilidadeSala.create(ambiente_id: self.ambiente_id, dia: self.dia,
                                horario_inicio: self.horario_inicio, horario_fim: self.horario_fim
      )
    end
  end


  def verificar_restricao_professor
    restricao_professor = Restricao.find_by(user_id: self.grade_curricular.user_id,
                          dia: self.dia, horario: self.horario_inicio)
    if restricao_professor
      errors.add(:base, "Professor selecionado possuí uma restrição para esse dia e horário.")
      throw :abort
    end
  end

  def verificar_aula_noite
    instituicao = Instituicao.find_by(id: self.grade_curricular.matriz_curricular_aplicada.curso.instituicao_id)
    horario_fim_insti = instituicao.horario_fim_aulas
    horario_inicio_insti = instituicao.horario_inicio_aula
    aula_salva_anterior = Aula.find_by(user_id: self.user_id)
    return if aula_salva_anterior.nil?

    aula_salva_anterior_primeira = aula_salva_anterior.dia + 1
    aula_salva_anterior_ultima = aula_salva_anterior.dia - 1
    if self.horario_fim == horario_fim_insti && aula_salva_anterior_primeira.horario_inicio == horario_inicio_insti
      errors.add(:base, "Professor já alocado na primeira aula do dia seguinte.")
      throw[:abort]
    elsif self.horario_inicio == horario_inicio_insti && aula_salva_anterior_ultima.horario_fim == horario_fim_insti
        errors.add(:base, "Professor já alocado na última aula do dia anterior.")
        throw :abort
    end
  end


  def set_horario_fim
    return unless self.horario_inicio.present?

    inicio = Time.parse(self.horario_inicio)
    fim = inicio + 50.minutes
    self.horario_fim = fim.strftime("%H:%M")
  end

  def verify_aula_igual
    aula_presente = Aula.where(
      ambiente_id: ambiente_id,
      dia: dia,
      horario_inicio: horario_inicio,
      grade_curricular_id: grade_curricular_id
    ).where.not(id: id).first

    if aula_presente
      errors.add(:base, "Esta aula com esses atributos já existe.")
      throw :abort
    end
  end

  def verify_aula_mesmo_horario
    if Aula.where(dia: dia, horario_inicio: horario_inicio, grade_curricular_id: grade_curricular_id)
           .where.not(id: id)
           .exists?
      errors.add(:base, "Já existe uma aula para este horário")
      throw :abort
    end
  end

  def verify_aula_professor_mesmo_horario
    return unless user_id.present?

    if Aula.where(dia: dia, horario_inicio: horario_inicio, user_id: user_id)
           .where.not(id: id)
           .exists?
      errors.add(:base, "Este professor já possui uma aula agendada para este horário em outra turma.")
      throw :abort
    end
  end


  def verify_aula_turmas
    return unless user_id.present?

    aula_presente = Aula.where(
      dia: dia,
      horario_inicio: horario_inicio,
      user_id: user_id
    ).where.not(id: id).first

    if aula_presente
      errors.add(:base, "Professor já ocupado neste dia e horário.")
      throw :abort
    end
  end
end
