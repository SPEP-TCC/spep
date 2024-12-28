class CreateGradesCurriculares < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:grades_curriculares)
      create_table :grades_curriculares do |t|
        t.references :disciplina, null: false, foreign_key: true
        t.integer :carga_horaria
        t.integer :periodo_calendario # 1, 2, 3, quatro. Se for ensino superior, apenas 1 e 2
        t.boolean :optativa
        t.references :matriz_curricular_aplicada, null: false, foreign_key: true
        t.references :user, null: false, foreign_key: true
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
