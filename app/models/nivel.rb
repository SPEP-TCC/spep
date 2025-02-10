class Nivel < ApplicationRecord
  has_many :etapas

  def to_s
    self.descricao
  end
end
