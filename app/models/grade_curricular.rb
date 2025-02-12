class GradeCurricular < ApplicationRecord
  belongs_to :disciplina
  belongs_to :matriz_curricular_aplicada
  belongs_to :user
  belongs_to :ambiente
  has_many :aulas

  def to_s
    "#{self.disciplina.descricao} - #{self.user.nome}"
  end
end
