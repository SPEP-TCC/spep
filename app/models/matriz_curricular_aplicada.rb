class MatrizCurricularAplicada < ApplicationRecord
  belongs_to :turno
  belongs_to :curso
  has_many :turmas
  has_many :grades_curriculares
  has_many :disciplinas, through: :grades_curriculares

  accepts_nested_attributes_for :grades_curriculares, allow_destroy: true

  def to_s
    self.descricao
  end
end
