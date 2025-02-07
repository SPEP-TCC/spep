class Disciplina < ApplicationRecord
  belongs_to :area, optional: true
  belongs_to :subarea, optional: true
  has_many :curriculo_ementa_disciplinas
  has_many :curriculo_ementas, through: :curriculo_ementa_disciplinas
  has_many :grades_curriculares

  def to_s
    self.descricao
  end
end
