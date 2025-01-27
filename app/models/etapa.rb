class Etapa < ApplicationRecord
  belongs_to :nivel
  has_many :areas
  has_many :cursos
end
