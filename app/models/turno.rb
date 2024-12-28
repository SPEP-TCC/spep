class Turno < ApplicationRecord
  has_many :matrizes_curriculares_aplicadas
  has_many :restricoes
  has_many :users, through: :restricoes
  has_many :turmas
end
