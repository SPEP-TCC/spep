# frozen_string_literal: true

class CreateTurmas < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:turmas)
      create_table :turmas do |t|
        t.string :descricao
        t.integer :vagas
        t.references :matriz_curricular_aplicada, foreign_key: true
        t.integer :numero_efetivo_estudantes
        t.boolean :sala_recorrente
        t.references :turno, null: true, foreign_key: true
        t.references :ambiente, null: true, foreign_key: true
        t.string :created_by
        t.string :updated_by
        t.datetime :deleted_at
        t.timestamps
      end
    end
  end

  def down
    drop_table :turmas if table_exists?(:turmas)
  end
end
