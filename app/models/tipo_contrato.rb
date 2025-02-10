class TipoContrato < ApplicationRecord
  has_many :users

  def to_s
    self.descricao
  end
end
