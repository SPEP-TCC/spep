class Ambiente < ApplicationRecord
  belongs_to :instituicao
  has_many :aulas
  has_many :disponibilidade_salas
  has_many :turmas
  has_many :grades_curriculares
end
