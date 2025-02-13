class Turma < ApplicationRecord
  belongs_to :matriz_curricular_aplicada
  belongs_to :turno, optional: true
  belongs_to :ambiente, optional: true
  has_many :grades_curriculares_turmas

  def to_s
    self.descricao
  end
end
