# frozen_string_literal: true

class CreateAulas < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:aulas)
      create_table :aulas do |t|
        t.references :grade_curricular, foreign_key: true, null: true
        t.references :ambiente, foreign_key: true, null: true
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
    drop_table :aulas if table_exists?(:aulas)
  end
end
