# frozen_string_literal: true

class CreateGradesCurriculares < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:grades_curriculares)
      create_table :grades_curriculares do |t|
        t.references :disciplina, foreign_key: true
        t.integer :carga_horaria
        t.integer :periodo_calendario
        t.boolean :optativa
        t.integer :carga_horaria_total
        t.references :matriz_curricular_aplicada, foreign_key: true
        t.references :user, foreign_key: true, null: true
        t.string :created_by
        t.string :updated_by
        t.datetime :deleted_at
        t.timestamps
      end
    end
  end

  def down
    drop_table :grades_curriculares if table_exists?(:grades_curriculares)
  end
end
