class Turma < ApplicationRecord
  belongs_to :matriz_curricular_aplicada
  belongs_to :turno
  belongs_to :ambiente

  def to_s
    self.descricao
  end
end
