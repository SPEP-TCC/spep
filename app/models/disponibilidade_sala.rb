class DisponibilidadeSala < ApplicationRecord
  belongs_to :ambiente

  def to_s
    self.descricao
  end
end
