class Aula < ApplicationRecord
  belongs_to :grade_curricular
  belongs_to :ambiente

  ### adicionar user_id a aula
  before_save :ocupar_ambiente
  before_save :verificar_restricao_professor

  def ocupar_ambiente
    ambiente_ocupado = DisponibilidadeSala.find_by(ambiente_id: self.ambiente_id,
                      dia: self.dia, horario_inicio: self.horario_inicio,
                      horario_fim: self.horario_fim)
    if ambiente_ocupado.exists?
      errors.add(:base, "Ambiente já ocupado para este dia e horário.")
      throw[:abort]
    else
      DisponibilidadeSala.create(ambiente_id: self.ambiente_id,
                      dia: self.dia, horario_inicio: self.horario_inicio,
                      horario_fim: self.horario_fim)
    end
  end

  def verificar_restricao_professor
    restricao_professor = Restricao.find_by(user_id: self.grade_curricular.user_id,
                          dia: self.dia, horario: self.horario_inicio)
    if restricao_professor.exists?
      errors.add(:base, "Professor selecionado possuí uma restrição para esse dia e horário.")
    end
  end

  def verificar_aula_noite
    instituicao = Instituicao.find_by(id: self.grade_curricular.matriz_curricular_aplicada.curso.instituicao_id)
    horario_fim_insti = instituicao.horario_fim_aulas
    horario_inicio_insti = instituicao.horario_inicio_aulas
    aula_salva_anterior = Aula.find_by(user_id: self.user_id)
    aula_salva_anterior = aula_salva_anterior.dia + 1
    if self.horario_fim == horario_fim_insti
      if aula_salva_anterior.horario_inicio == horario_inicio_insti
        errors.add(:base, "Professor já alocado na primeira aula do dia seguinte.")
        throw[:abort]
      end

    end
  end
end
