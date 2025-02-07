class CurriculoEmentaDisciplina < ApplicationRecord
  belongs_to :curriculo_ementa
  belongs_to :disciplina

  def to_s
    self.descricao
  end
end
