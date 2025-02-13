# frozen_string_literal: true

class CreateGradesCurricularesTurmas < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:grades_curriculares_turmas)
      create_table :grades_curriculares_turmas do |t|
        t.references :grade_curricular, foreign_key: true
        t.references :turma, foreign_key: true
        t.string :created_by
        t.string :updated_by
        t.datetime :deleted_at
        t.timestamps
      end
    end
  end

  def down
    drop_table :grades_curriculares_turmas if table_exists?(:grades_curriculares_turmas)
  end
end
