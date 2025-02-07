class Curso < ApplicationRecord
  belongs_to :etapa
  belongs_to :curriculo_ementa
  belongs_to :instituicao
  belongs_to :modalidade
  has_many :matrizes_curriculares_aplicadas

  def to_s
    self.descricao
  end
end
