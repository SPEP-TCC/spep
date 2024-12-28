class Disciplina < ApplicationRecord
  belongs_to :area
  belongs_to :subarea
  has_many :curriculo_ementa_disciplinas
  has_many :curriculo_ementas, through: :curriculo_ementa_disciplinas
  has_many :grades_curriculares
end
