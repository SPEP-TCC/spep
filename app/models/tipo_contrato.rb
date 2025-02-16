class TipoContrato < ApplicationRecord
  has_many :users

  def to_s
    "#{self.descricao} - #{self.carga_horaria}h"
  end
end
