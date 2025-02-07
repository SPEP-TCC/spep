class Etapa < ApplicationRecord
  belongs_to :nivel
  has_many :areas
  has_many :cursos

  def to_s
    self.descricao
  end
end
