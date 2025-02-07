class CurriculoEmenta < ApplicationRecord
  has_many :curriculo_ementa_disciplinas
  has_many :disciplinas, through: :curriculo_ementa_disciplinas
  has_many :cursos

  def to_s
    self.descricao
  end
end
