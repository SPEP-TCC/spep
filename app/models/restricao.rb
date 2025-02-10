class Restricao < ApplicationRecord
  belongs_to :user
  belongs_to :turno

  def to_s
    self.descricao
  end
end
