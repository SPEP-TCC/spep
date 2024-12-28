class GradeCurricular < ApplicationRecord
  belongs_to :disciplina
  belongs_to :matriz_curricular_aplicada
  belongs_to :user
end
