# frozen_string_literal: true

class CreateDisponibilidadeSalas < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:disponibilidade_salas)
      create_table :disponibilidade_salas do |t|
        t.references :ambiente, foreign_key: true
        t.integer :dia
        t.string :horario_inicio
        t.string :horario_fim
        t.string :created_by
        t.string :updated_by
        t.datetime :deleted_at
        t.timestamps
      end
    end
  end

  def down
    drop_table :disponibilidade_salas if table_exists?(:disponibilidade_salas)
  end
end
