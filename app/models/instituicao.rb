class Instituicao < ApplicationRecord
  has_many :cursos

  def to_s
    self.nome
  end
end
