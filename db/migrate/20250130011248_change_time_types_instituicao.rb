class ChangeTimeTypesInstituicao < ActiveRecord::Migration[7.2]
  def up
    # Adiciona novas colunas temporárias do tipo time
    add_column :instituicoes, :horario_inicio_aula_tmp, :time
    add_column :instituicoes, :horario_fim_aulas_tmp, :time

    # Converte os valores inteiros (assumindo que representam segundos ou HHMM)
    execute <<-SQL
      UPDATE instituicoes
      SET horario_inicio_aula_tmp =
        to_timestamp(horario_inicio_aula::integer)::time,
          horario_fim_aulas_tmp =
        to_timestamp(horario_fim_aulas::integer)::time
    SQL

    # Remove as colunas antigas
    remove_column :instituicoes, :horario_inicio_aula
    remove_column :instituicoes, :horario_fim_aulas

    # Renomeia as colunas temporárias para os nomes corretos
    rename_column :instituicoes, :horario_inicio_aula_tmp, :horario_inicio_aula
    rename_column :instituicoes, :horario_fim_aulas_tmp, :horario_fim_aulas
  end

  def down
    # Reverte a mudança voltando para integer
    add_column :instituicoes, :horario_inicio_aula_tmp, :integer
    add_column :instituicoes, :horario_fim_aulas_tmp, :integer

    # Se precisar reverter, converte de volta (supondo que armazena segundos)
    execute <<-SQL
      UPDATE instituicoes
      SET horario_inicio_aula_tmp =
        extract(epoch FROM horario_inicio_aula)::integer,
          horario_fim_aulas_tmp =
        extract(epoch FROM horario_fim_aulas)::integer
    SQL

    remove_column :instituicoes, :horario_inicio_aula
    remove_column :instituicoes, :horario_fim_aulas

    rename_column :instituicoes, :horario_inicio_aula_tmp, :horario_inicio_aula
    rename_column :instituicoes, :horario_fim_aulas_tmp, :horario_fim_aulas
  end
end
