class ChangeTimeTypesInstituicao < ActiveRecord::Migration[7.2]
  def up
    change_column :instituicoes, :horario_inicio_aula, :string
    change_column :instituicoes, :horario_fim_aulas, :string
  end

  def down
    change_column :instituicoes, :horario_inicio_aula, :integer
    change_column :instituicoes, :horario_fim_aulas, :integer
  end
end
