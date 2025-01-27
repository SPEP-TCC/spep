class Area < ApplicationRecord
  belongs_to :etapa
  has_many :disciplinas
  has_many :subareas
end
