# frozen_string_literal: true

class Metodologia < ApplicationRecord
  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos

  def to_s
    self.descricao
  end
end
