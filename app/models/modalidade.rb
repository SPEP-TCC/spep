class Modalidade < ApplicationRecord
  has_many :cursos

  def to_s
    self.descricao
  end
end
