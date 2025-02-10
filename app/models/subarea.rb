class Subarea < ApplicationRecord
  belongs_to :area
  has_many :disciplinas

  def to_s
    self.descricao
  end
end
