class MatrizCurricularAplicada < ApplicationRecord
  belongs_to :turno
  belongs_to :curso
  has_many :grades_curriculares
  has_many :turmas
end
