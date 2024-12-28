class Curso < ApplicationRecord
  belongs_to :etapa
  belongs_to :curriculo_ementa
  belongs_to :instituicao
  belongs_to :modalidade
  belongs_to :metodologia
  has_many :matrizes_curriculares_aplicadas
end
